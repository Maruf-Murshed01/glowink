import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      print('AuthService: Starting signup process');
      print('AuthService: Firebase Auth instance: ${_auth.toString()}');

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(
          'AuthService: Signup successful for user: ${userCredential.user?.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('AuthService: FirebaseAuthException');
      print('AuthService: Error code: ${e.code}');
      print('AuthService: Error message: ${e.message}');
      rethrow;
    } catch (e) {
      print('AuthService: Unknown error: $e');
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during sign in';
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
