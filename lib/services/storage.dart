import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final Reference storageReference = FirebaseStorage.instance.ref();

  Future<String> uploadPostMap(Uint8List image, String postId) async {
    UploadTask uploadTask = storageReference
        .child("Posted Picture")
        .child("post_$postId.png")
        .putData(image);
    TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    return url;
  }

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

  Future<bool> removePostImage(String postId) async {
    try {
      storageReference
          .child("Posted Picture")
          .child("post_$postId.png")
          .delete();
      return true;
    } catch (_) {
      return false;
    }
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
      await reference.delete();
      return true;
    } catch (e) {
      print('Storage error: ' + e);
      return false;
    }
  }
}
