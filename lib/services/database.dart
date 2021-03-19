import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';

class DatabaseServices {
  final String uid;

  DatabaseServices({this.uid});

  // Post owner getter
  Future<SimplifiedUser> getSimplifiedUser() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    return SimplifiedUser.fromDocument(documentSnapshot);
  }

  // User data getter
  Future<ModifiedUser> getUserData() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    return ModifiedUser.fromDocument(documentSnapshot);
  }

  // Create user data in 'Users' colection of firebase firestore
  Future<void> createUserData(String uid, String email, String firstName,
      String lastName, String avtUrl) async {
    return await FirebaseFirestore.instance.collection('Users').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': firstName + ' ' + lastName,
      'avtUrl': avtUrl,
      'bio': '',
      'registerTime': Timestamp.now(),
      'following': <String>[],
      'follower': <String>[],
      'totalDistance': 0.0,
      'totalTime': 0.0,
      'height': 0.0,
      'weight': 0.0,
    });
  }

  Future<void> updateRun(double newDistance, double newTime) async {
    DocumentSnapshot currentUser =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    double newTotalDistance =
        (currentUser.data()['totalDistance'] ?? 0.0) + newDistance;
    double newTotalTime = (currentUser.data()['totalTime'] ?? 0.0) + newTime;
    FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'totalDistance': newTotalDistance,
      'totalTime': newTotalTime,
    });
  }

  Future<void> follow(String followId) async {
    DocumentSnapshot following =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    DocumentSnapshot follower = await FirebaseFirestore.instance
        .collection('Users')
        .doc(followId)
        .get();
    List<dynamic> followingData = following.data()['following'] ?? <String>[];
    List<dynamic> followerData = follower.data()['follower'] ?? <String>[];
    if (!followingData.contains(followId)) {
      followingData.add(followId);
      FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'following': followingData,
      });
    }
    if (!followerData.contains(uid)) {
      followerData.add(uid);
      FirebaseFirestore.instance.collection('Users').doc(followId).update({
        'follower': followerData,
      });
    }
  }

  Future<void> unfollow(String followId) async {
    DocumentSnapshot following =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    DocumentSnapshot follower = await FirebaseFirestore.instance
        .collection('Users')
        .doc(followId)
        .get();
    List<dynamic> followingData = following.data()['following'] ?? <String>[];
    List<dynamic> followerData = follower.data()['follower'] ?? <String>[];
    followingData.remove(followId);
    followerData.remove(uid);
    FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'following': followingData,
    });
    FirebaseFirestore.instance.collection('Users').doc(followId).update({
      'follower': followerData,
    });
  }

  Future<void> like(String owner, String postId) async {
    DocumentSnapshot post = await FirebaseFirestore.instance
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .get();
    List<dynamic> userLike = post.data()['userLike'] ?? <String>[];
    if (!userLike.contains(uid)) {
      userLike.add(uid);
      FirebaseFirestore.instance
          .collection('Posts')
          .doc(owner)
          .collection('UserPosts')
          .doc(postId)
          .update({
        'userLike': userLike,
      });
    }
  }

  Future<void> dislike(String owner, String postId) async {
    DocumentSnapshot post = await FirebaseFirestore.instance
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .get();
    List<dynamic> userLike = post.data()['userLike'] ?? <String>[];
    userLike.remove(uid);
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .update({
      'userLike': userLike,
    });
  }

  Future<Post> createPostData(
      String pid, String imgUrl, String description, String location) async {
    DocumentReference userPostsRef =
        FirebaseFirestore.instance.collection('Posts').doc(uid);
    Timestamp timestamp = Timestamp.now();
    await userPostsRef.collection('UserPosts').doc(pid).set({
      'pid': pid,
      'ownerId': uid,
      'imgUrl': imgUrl,
      'description': description,
      'location': location,
      'postTime': timestamp,
      'userLike': <String>[],
    });
    return Post(
      pid: pid,
      ownerId: uid,
      imgUrl: imgUrl,
      description: description,
      location: location,
      postTime: timestamp.toDate(),
      userLike: <String>[],
    );
  }

  Future<void> removePost(String postId) async {
    return await FirebaseFirestore.instance
        .collection('Posts')
        .doc(uid)
        .collection('UserPosts')
        .doc(postId)
        .delete();
  }

  // Post list in Future
  Future<List<Post>> getPostList() async {
    ModifiedUser currentUser = await getUserData();
    List<dynamic> following = currentUser.following + [uid];
    List<Post> posts = <Post>[];
    for (String followingUser in following) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(followingUser)
          .collection('UserPosts')
          .where('postTime',
              isGreaterThanOrEqualTo:
                  Timestamp.fromDate(DateTime.now().add(Duration(days: -1))))
          .get();
      posts += querySnapshot.docs.map((doc) {
        return Post(
          pid: doc.data()['pid'] ?? '',
          ownerId: doc.data()['ownerId'] ?? '',
          imgUrl: doc.data()['imgUrl'] ?? '',
          description: doc.data()['description'] ?? '',
          location: doc.data()['location'] ?? '',
          postTime: (doc.data()['postTime'] ?? Timestamp.now()).toDate(),
          userLike: doc.data()['userLike'] ?? <String>[],
        );
      }).toList();
      posts.sort((a, b) {
        return b.postTime.compareTo(a.postTime);
      });
    }
    return posts;
  }

  Stream<List<Post>> get userPosts {
    return FirebaseFirestore.instance
        .collection('Posts')
        .doc(uid)
        .collection('UserPosts')
        .snapshots()
        .map((doc) {
      return doc.docs.map((doc) {
        return Post(
          pid: doc.data()['pid'] ?? '',
          ownerId: doc.data()['ownerId'] ?? '',
          imgUrl: doc.data()['imgUrl'] ?? '',
          description: doc.data()['description'] ?? '',
          location: doc.data()['location'] ?? '',
          postTime: (doc.data()['postTime'] ?? Timestamp.now()).toDate(),
          userLike: doc.data()['userLike'] ?? <String>[],
        );
      }).toList();
    });
  }

  static Future<List<LeaderBoardUser>> getDistanceLeaderBoard(int limit) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('totalDistance', descending: true)
        .limit(limit)
        .get();
    return querySnapshot.docs.map((doc) {
      return LeaderBoardUser.fromQueryDocument(doc);
    }).toList();
  }

  static Future<List<SearchedUser>> searchUser(String key) async {
    if (key == '' || key == null) return [];
    QuerySnapshot emailQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: key)
        .get();

    List<SearchedUser> searchedUser = emailQuerySnapshot.docs.map((doc) {
      return SearchedUser.fromQueryDocument(doc);
    }).toList();

    QuerySnapshot nameQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('name', isGreaterThanOrEqualTo: key)
        .where('name', isLessThanOrEqualTo: key + '\uf8ff')
        .get();

    searchedUser += nameQuerySnapshot.docs.map((doc) {
      return SearchedUser.fromQueryDocument(doc);
    }).toList();
    return searchedUser;
  }

  Future<bool> updateUserProfile(String firstName, String lastName,
      double height, double weight, String bio) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'name': firstName + ' ' + lastName,
        'height': height,
        'weight': weight,
        'bio': bio,        
      });
      return true;
    } catch (e) {
      print('Database error: ' + e);
      return false;
    }
  }
}
