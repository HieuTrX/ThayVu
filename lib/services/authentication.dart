import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', result.user.uid);
    prefs.setString('email', result.user.email);
    return result.user.uid;
  }

  Future<String> signUp(String email, String password) async {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
