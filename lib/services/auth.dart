import 'package:firebase_auth/firebase_auth.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static User user;

  // Create user object based on FirebaseUser
  Future<ModifiedUser> userFromFirebaseUser() async {
    User currentUser = firebaseAuth.currentUser;
    return (currentUser != null)
        ? await DatabaseServices(uid: user.uid).getUserData()
        : null;
  }

  // Auth change user stream
  Stream<String> get userCurrentId {
    return firebaseAuth.authStateChanges().map((event) => event?.uid);
  }

  // Sign in with email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = result.user;
      return user?.uid;
    } catch (e) {
      print("Sign in error: " + e.toString());
      return null;
    }
  }

  // Register with email and password
  Future<String> registerWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = result.user;
      await DatabaseServices(uid: user.uid).createUserData(
          user.uid,
          email,
          firstName,
          lastName,
          null);
      return user?.uid;
    } catch (e) {
      print("Register error: " + e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      user = null;
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> changePassword(String newPassword) async {
    try {
      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
