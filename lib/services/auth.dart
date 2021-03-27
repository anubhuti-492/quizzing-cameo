import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;
  //anonymous sign in
  Future<FirebaseUser> anonLogin() async {
      try {
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser user = result.user;
        /// Update user data
        updateUserData(user);
        return user;
      } on Exception catch (e) {
          print("sorry, an error had occured. "+e.toString());
          return null;
      }
  }
  /// Sign in with Google
  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;

     /// Update user data
     updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }
  //get firebase user one-time using a future
  Future<FirebaseUser> get getUser {
      return _auth.currentUser();
  }
  //get firebase user using a realtime stream
  Stream<FirebaseUser> get user {
      return _auth.onAuthStateChanged;
  }

  /// Updates the User's data in Firestore on each new login
  /// Firestore will map each report with the uid that is generated
  /// it will create a collection called Report whenever a user logs in.
  /// if the collection with that uid does not exist, firestore will
  /// create a new collection.
  ///
  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('reports').document(user.uid);

    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }

  Future<void> signOut() {
    try {
      return _auth.signOut();
      print("has been logged out successfully");
    } on Exception catch (e) {
      print("has not been logged out successfully");
    }
  }
}