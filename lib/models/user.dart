import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardUser {
  final uid;
  final name;
  final String avtUrl;
  final double totalDistance;

  LeaderBoardUser({
    this.uid = '',
    this.name = '',
    this.avtUrl =
        'https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f',
    this.totalDistance = 0.0,
  });

  factory LeaderBoardUser.fromQueryDocument(QueryDocumentSnapshot document) {
    return LeaderBoardUser(
      uid: document.data()["uid"] ?? "",
      name: document.data()["name"] ?? "",
      avtUrl: document.data()["avtUrl"] ??
          "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f",
      totalDistance: document.data()["totalDistance"] ?? 0.0,
    );
  }
}

class SearchedUser {
  final String uid;
  final String name;
  final String email;
  final String avtUrl;

  SearchedUser({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.avtUrl =
        'https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f',
  });

  factory SearchedUser.fromDocument(DocumentSnapshot document) {
    return SearchedUser(
      uid: document.data()["uid"] ?? "",
      name: document.data()["name"] ?? "",
      email: document.data()["email"] ?? "",
      avtUrl: document.data()["avtUrl"] ??
          "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f",
    );
  }

  factory SearchedUser.fromQueryDocument(QueryDocumentSnapshot document) {
    return SearchedUser(
      uid: document.data()["uid"] ?? "",
      name: document.data()["name"] ?? "",
      email: document.data()["email"] ?? "",
      avtUrl: document.data()["avtUrl"] ??
          "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f",
    );
  }
}

class SimplifiedUser {
  final String name;
  final String avtUrl;

  SimplifiedUser({
    this.name = '',
    this.avtUrl =
        'https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f',
  });

  factory SimplifiedUser.fromDocument(DocumentSnapshot document) {
    return SimplifiedUser(
      name: document.data()["name"] ?? "",
      avtUrl: document.data()["avtUrl"] ??
          "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f",
    );
  }

  factory SimplifiedUser.fromQueryDocument(QueryDocumentSnapshot document) {
    return SimplifiedUser(
      name: document.data()["name"] ?? "",
      avtUrl: document.data()["avtUrl"] ??
          "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f",
    );
  }
}

class ModifiedUser {
  final String uid;
  final String email;
  final String name;
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
      this.name = '',
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
      name: document.data()["name"] ?? "",
      avtUrl: document.data()["avtUrl"] ?? "",
      bio: document.data()["bio"] ?? "",
      following: document.data()["following"],
      follower: document.data()["follower"],
      totalDistance: document.data()["totalDistance"] ?? 0.0,
      totalTime: document.data()["totalTime"] ?? 0.0,
      height: document.data()["height"] ?? 0.0,
      weight: document.data()["weight"] ?? 0.0,
    );
  }
}
