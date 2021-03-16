import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';

class DatabaseServices {
  final String uid;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  DatabaseServices({this.uid});

  // Post owner getter
  Future<PostOwner> getPostOwner() async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(uid).get();
    return PostOwner.fromDocument(documentSnapshot);
  }

  // User data getter
  Future<ModifiedUser> getUserData() async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(uid).get();
    return ModifiedUser.fromDocument(documentSnapshot);
  }

  // Create user data in 'Users' colection of firebase firestore
  Future<void> createUserData(String uid, String email, String firstName,
      String lastName, String avtUrl) async {
    return await firebaseFirestore.collection('Users').doc(uid).set({
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avtUrl': avtUrl,
      'bio': '',
      'registerTime': Timestamp.now(),
      'following': <String>[],
      'follower': <String>[],
      'totalDistance': 0.0,
      'totalTime': 0,
      'height': 0.0,
      'weight': 0.0,
    });
  }

  Future<void> updateRun(double newDistance, int newTime) async {
    DocumentSnapshot currentUser =
        await firebaseFirestore.collection('Users').doc(uid).get();
    double newTotalDistance =
        (currentUser.data()['totalDistance'] ?? 0.0) + newDistance;
    int newTotalTime = (currentUser.data()['totalTime'] ?? 0.0) + newTime;
    firebaseFirestore.collection('Users').doc(uid).update({
      'totalDistance': newTotalDistance,
      'totalTime': newTotalTime,
    });
  }

  Future<void> follow(String followId) async {
    DocumentSnapshot following =
        await firebaseFirestore.collection('Users').doc(uid).get();
    DocumentSnapshot follower =
        await firebaseFirestore.collection('Users').doc(followId).get();
    List<dynamic> followingData = following.data()['following'] ?? <String>[];
    List<dynamic> followerData = follower.data()['follower'] ?? <String>[];
    followingData.add(followId);
    followerData.add(uid);
    firebaseFirestore.collection('Users').doc(uid).update({
      'following': followingData,
    });
    firebaseFirestore.collection('Users').doc(followId).update({
      'follower': followerData,
    });
  }

  Future<void> unfollow(String followId) async {
    DocumentSnapshot following =
        await firebaseFirestore.collection('Users').doc(uid).get();
    DocumentSnapshot follower =
        await firebaseFirestore.collection('Users').doc(followId).get();
    List<dynamic> followingData = following.data()['following'] ?? <String>[];
    List<dynamic> followerData = follower.data()['follower'] ?? <String>[];
    followingData.remove(followId);
    followerData.remove(uid);
    firebaseFirestore.collection('Users').doc(uid).update({
      'following': followingData,
    });
    firebaseFirestore.collection('Users').doc(followId).update({
      'follower': followerData,
    });
  }

  Future<void> like(String owner, String postId) async {
    DocumentSnapshot post = await firebaseFirestore
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .get();
    List<dynamic> userLike = post.data()['userLike'] ?? <String>[];
    userLike.add(uid);
    firebaseFirestore
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .update({
      'userLike': userLike,
    });
  }

  Future<void> dislike(String owner, String postId) async {
    DocumentSnapshot post = await firebaseFirestore
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .get();
    List<dynamic> userLike = post.data()['userLike'] ?? <String>[];
    userLike.remove(uid);
    firebaseFirestore
        .collection('Posts')
        .doc(owner)
        .collection('UserPosts')
        .doc(postId)
        .update({
      'userLike': userLike,
    });
  }

  Future<Post> updatePostData(
      String pid, String imgUrl, String description, String location) async {
    DocumentReference userPostsRef =
        firebaseFirestore.collection('Posts').doc(uid);
    await userPostsRef.set({
      'ownerId': uid,
    });
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
    return await firebaseFirestore
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
      QuerySnapshot querySnapshot = await firebaseFirestore
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
    return firebaseFirestore
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

  Future<void> updateEmail(String newEmail) async {
    await firebaseFirestore.collection('Users').doc(uid).update({
      'email': newEmail,
    });
  }
}
