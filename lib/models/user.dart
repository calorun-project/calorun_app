import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardUser {
  final String firstName;
  final String lastName;
  final String avtUrl;
  final double totalDistance;

  LeaderBoardUser({
    this.firstName = '',
    this.lastName = '',
    this.avtUrl =
        'https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f',
    this.totalDistance = 0.0,
  });

  factory LeaderBoardUser.fromDocument(QueryDocumentSnapshot document) {
    return LeaderBoardUser(
      firstName: document.data()["firstName"] ?? "",
      lastName: document.data()["lastName"] ?? "",
      avtUrl: document.data()["avtUrl"] ?? "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f",
      totalDistance: document.data()["totalDistance"] ?? 0.0,
    );
  }
}

class SimplifiedUser {
  final String firstName;
  final String lastName;
  final String avtUrl;

  SimplifiedUser({
    this.firstName = '',
    this.lastName = '',
    this.avtUrl =
        'https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f',
  });

  factory SimplifiedUser.fromDocument(DocumentSnapshot document) {
    return SimplifiedUser(
      firstName: document.data()["firstName"] ?? "",
      lastName: document.data()["lastName"] ?? "",
      avtUrl: document.data()["avtUrl"] ?? "",
    );
  }
}

class ModifiedUser {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String avtUrl;
  final String bio;
  final List<dynamic> following;
  final List<dynamic> follower;
  final double totalDistance;
  final double totalTime;
  final double height;
  final double weight;

  ModifiedUser(
      {this.uid = '',
      this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.avtUrl =
          'https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f',
      this.bio = '',
      this.following = const [],
      this.follower = const [],
      this.totalDistance = 0.0,
      this.totalTime = 0.0,
      this.height = 0.0,
      this.weight = 0.0});

  factory ModifiedUser.fromDocument(DocumentSnapshot document) {
    return ModifiedUser(
      uid: document.data()["uid"] ?? "",
      email: document.data()["email"] ?? "",
      firstName: document.data()["firstName"] ?? "",
      lastName: document.data()["lastName"] ?? "",
      avtUrl: document.data()["avtUrl"] ?? "",
      bio: document.data()["bio"] ?? "",
      following: document.data()["following"] ?? <String>[],
      follower: document.data()["follower"] ?? <String>[],
      totalDistance: document.data()["totalDistance"] ?? 0.0,
      totalTime: document.data()["totalTime"] ?? 0.0,
      height: document.data()["height"] ?? 0.0,
      weight: document.data()["weight"] ?? 0.0,
    );
  }
}
