import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ✅ Static register — matches: bool success = await AuthService.register(...)
  static Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create user in Firebase Auth
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user!;

      // 2. Update display name
      await user.updateDisplayName('$firstName $lastName');

      // 3. Save details to Firestore /users/{uid}
      await _db.collection('users').doc(user.uid).set({
        'uid':         user.uid,
        'firstName':   firstName.trim(),
        'lastName':    lastName.trim(),
        'email':       email.trim(),
        'displayName': '$firstName $lastName',
        'createdAt':   FieldValue.serverTimestamp(),
      });

      return true; // ✅ success

    } on FirebaseAuthException catch (e) {
      print('Registration failed [${e.code}]: ${e.message}');
      return false;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // ✅ Static login
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Login failed [${e.code}]: ${e.message}');
      return false;
    }
  }

  // ✅ Static sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // ✅ Current user
  static User? get currentUser => _auth.currentUser;

  // ✅ Friendly error messages for UI display
  static String getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'api-key-not-valid':
        return 'Firebase not configured. Check your firebase_options.dart.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}