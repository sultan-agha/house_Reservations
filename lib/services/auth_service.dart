import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Auth {
  // // google sign in(for later uses)
  // signInWithGoogle() async {
  //   //begin interactive sign in process
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();//make us open the page to choose the account
  //   //obtain auth details from req
  //   final GoogleSignInAuthentication gAuth =await gUser!.authentication;
  //   //create a new credential for user
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken,
  //     idToken: gAuth.idToken,
  //   );
  //   //finally lets sign in
  //   return await FirebaseAuth.instance.signInWithCredential(credential);


  final FirebaseAuth _FirebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _FirebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _FirebaseAuth.authStateChanges();

  // for email and pass verification
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _FirebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // for register
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _FirebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _FirebaseAuth.signOut();
  }
}