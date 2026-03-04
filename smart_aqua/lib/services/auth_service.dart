import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ✅ Static register — matches: bool success = await AuthService.register(...)
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String email,
    required String password,
  }) async {
    try {
      print('DEBUG: Starting registration for $email');

      // 1. Create user in Firebase Auth
      final credential = await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw FirebaseAuthException(
            code: 'network-request-failed', message: 'Auth timeout');
      });

      final user = credential.user!;
      print('DEBUG: Auth user created: ${user.uid}');

      // 2. Update display name
      await user.updateDisplayName(firstName);
      print('DEBUG: Display name updated');

      // 3. Save details to Firestore /users/{uid}
      // Added timeout to prevent infinite hang if Firestore is unreachable
      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'firstName': firstName.trim(),
        'email': email.trim(),
        'displayName': firstName.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        print('DEBUG: Firestore write timed out');
        // We don't necessarily want to fail registration if only Firestore fails,
        // but for now let's track it.
        throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'timeout',
            message: 'Firestore write timed out');
      });

      print('DEBUG: Firestore write success');
      return {'success': true};
    } on FirebaseAuthException catch (e) {
      print('DEBUG: Registration failed [${e.code}]: ${e.message}');
      return {'success': false, 'error': getErrorMessage(e.code)};
    } on FirebaseException catch (e) {
      print('DEBUG: Firestore error [${e.code}]: ${e.message}');
      return {'success': false, 'error': 'Database error: ${e.message}'};
    } catch (e) {
      print('DEBUG: Registration error: $e');
      return {'success': false, 'error': 'An unexpected error occurred: $e'};
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
