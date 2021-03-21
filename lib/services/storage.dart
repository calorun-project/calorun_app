import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final Reference storageReference = FirebaseStorage.instance.ref();

  Future<String> uploadPostImage(File image, String postId) async {
    UploadTask uploadTask = storageReference
        .child("Posted Picture")
        .child("post_$postId.png")
        .putFile(image);
    TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    return url;
  }

  void removePostImage(String postId) {
    storageReference.child("Posted Picture").child("post_$postId.png").delete();
  }

  Future<String> newAvatar(File image, String uid) async {
    UploadTask uploadTask = storageReference
        .child("Users Avatar")
        .child("avt_$uid.png")
        .putFile(image);
    TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => print("avt_$uid.png uploaded."));
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<bool> removeUserAvatar(String uid) async {
    try {
      Reference reference =
          storageReference.child("Users Avatar").child("avt_$uid.png");
      if (reference.bucket.isNotEmpty) return true;
      await reference.delete();
      return true;
    } catch (e) {
      print('Storage error: ' + e);
      return false;
    }
  }
}
