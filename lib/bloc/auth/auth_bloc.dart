import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AuthStatus status;
  final String? error;
  final String? username;
  final String? id;

  const AuthState(
      {this.status = AuthStatus.initial, this.error, this.username, this.id});
}

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(const AuthState()) {
    _init();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool get isLoggedIn => state.status == AuthStatus.success;

  Future<void> _init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? id = prefs.getString('id');
    print('HEllo $username');
    if (username != null) {
      emit(AuthState(status: AuthStatus.success, username: username, id: id));
    } else {
      emit(const AuthState());
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    emit(const AuthState(status: AuthStatus.loading));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: '$username@oceancleanup.com',
        password: password,
      );

      if (userCredential.user != null) {
        emit(AuthState(
            status: AuthStatus.success,
            username: username,
            id: userCredential.user!.uid));
        await prefs.setString('id', userCredential.user!.uid);
        await prefs.setString('username', username);
      } else {
        emit(const AuthState(
            status: AuthStatus.failure, error: 'Invalid credentials'));
      }
    } catch (e) {
      emit(const AuthState(status: AuthStatus.failure, error: 'Login failed'));
    }
  }

  Future<void> signOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('username');
    await FirebaseAuth.instance.signOut();
    emit(const AuthState());
  }

  Future<void> signUp(
      {required String username, required String password}) async {
    emit(const AuthState(status: AuthStatus.loading));
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: '$username@oceancleanup.com',
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'score': 0,
      });

      emit(AuthState(
        status: AuthStatus.success,
        username: username,
        id: userCredential.user!.uid,
      ));
    } catch (e) {
      emit(const AuthState(status: AuthStatus.failure, error: 'Signup failed'));
    }
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      if (userId != '') {
        final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await _firestore.collection('users').doc(userId).get();
        if (userSnapshot.exists) {
          return UserModel(
            id: userId,
            username: userSnapshot.data()!['username'] ?? '',
            score: userSnapshot.data()!['score'] ?? 0,
          );
        }
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return null;
  }

  Future<void> updateScore(int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('id');
    if (id != null) {
      await _firestore.collection('users').doc(id).update({'score': score});
    }
  }
}
