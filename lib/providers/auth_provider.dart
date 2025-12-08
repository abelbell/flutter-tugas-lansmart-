import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoggedIn = false;
  bool _loading = false;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  bool get loading => _loading;
  Map<String, dynamic>? get userData => _userData;

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _isLoggedIn = true;
        _fetchUserProfile(user.uid);
      } else {
        _isLoggedIn = false;
        _userData = null;
      }
      notifyListeners();
    });
  }

  // ---------------------------
  // REGISTER USER
  // ---------------------------
  Future<String> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      UserCredential userCred =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(userCred.user!.uid).set({
        "name": name,
        "email": email,
        "location":"",
        "phone":"",
        "createdAt": DateTime.now(),
      });

      _loading = false;
      notifyListeners();
      return "success";
    } on FirebaseAuthException catch (e) {
      _loading = false;
      notifyListeners();
      return e.message ?? "Unknown Firebase error";
    }
  }

  // ---------------------------
  // LOGIN USER
  // ---------------------------
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _loading = false;
      notifyListeners();
      return "success";
    } on FirebaseAuthException catch (e) {
      _loading = false;
      notifyListeners();
      print(e);
      return e.message ?? "Unknown Firebase error";
    }
  }

  // ---------------------------
  // LOGOUT
  // ---------------------------
  Future<void> logoutUser() async {
    await _auth.signOut();
    _isLoggedIn = false;
    _userData = null;
    notifyListeners();
  }

  // ---------------------------
  // GET USER PROFILE
  // ---------------------------
  Future<void> _fetchUserProfile(String uid) async {
    DocumentSnapshot doc =
    await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      _userData = doc.data() as Map<String, dynamic>;
    }
    notifyListeners();
  }

  // ---------------------------
  // UPDATE PROFILE
  // ---------------------------
  Future<void> updateProfile({
    required String name,
  }) async {
    String uid = _auth.currentUser!.uid;

    await _firestore.collection("users").doc(uid).update({
      "name": name,
      "updatedAt": DateTime.now(),
    });

    _userData?["name"] = name;
    notifyListeners();
  }

  // ---------------------------
  // DELETE PROFILE
  // ---------------------------
  Future<void> deleteProfile() async {
    String uid = _auth.currentUser!.uid;

    await _firestore.collection("users").doc(uid).delete();
    await _auth.currentUser!.delete();

    _userData = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
