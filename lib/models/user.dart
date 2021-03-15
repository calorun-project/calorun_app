import 'package:cloud_firestore/cloud_firestore.dart';

class PostOwner {
  final String firstName;
  final String lastName;
  final String avtUrl;

  PostOwner({
    this.firstName,
    this.lastName,
    this.avtUrl,
  });

  factory PostOwner.fromDocument(DocumentSnapshot document) {
    return PostOwner(
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
  final List<dynamic> following;
  final List<dynamic> follower;
  final double totalDistance;
  final double totalTime;
  final double height;
  final double weight;

  ModifiedUser(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.avtUrl,
      this.following,
      this.follower,
      this.totalDistance,
      this.totalTime,
      this.height,
      this.weight});

  factory ModifiedUser.fromDocument(DocumentSnapshot document) {
    return ModifiedUser(
      uid: document.data()["uid"] ?? "",
      email: document.data()["email"] ?? "",
      firstName: document.data()["firstName"] ?? "",
      lastName: document.data()["lastName"] ?? "",
      avtUrl: document.data()["avtUrl"] ?? "",
      following: document.data()["following"] ?? <String>[],
      follower: document.data()["follower"] ?? <String>[],
      totalDistance: document.data()["totalDistance"] ?? 0.0,
      totalTime: document.data()["totalTime"] ?? 0.0,
      height: document.data()["height"] ?? 0.0,
      weight: document.data()["weight"] ?? 0.0,
    );
  }
}
