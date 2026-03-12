import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user!;
      print('DEBUG: User created: ${user.uid}');

      await user.updateDisplayName(firstName.trim());

      await user.sendEmailVerification();
      print('DEBUG: Verification email sent to ${user.email}');

      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'firstName': firstName.trim(),
        'email': email.trim(),
        'displayName': firstName.trim(),
        'emailVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('DEBUG: Firestore write success');

      await _auth.signOut();

      return {'success': true};
    } on FirebaseAuthException catch (e) {
      print('DEBUG: Register error [${e.code}]: ${e.message}');
      return {'success': false, 'error': getErrorMessage(e.code)};
    } catch (e) {
      print('DEBUG: Unexpected error: $e');
      return {'success': false, 'error': 'An unexpected error occurred.'};
    }
  }

  // ✅ PASTE REPLACES FROM HERE
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ).timeout(const Duration(seconds: 30), onTimeout: () {
        throw FirebaseAuthException(
          code: 'network-request-failed',
          message: 'Login timed out',
        );
      });

      final user = credential.user!;

      // Reload to get latest emailVerified status
      await user.reload().timeout(const Duration(seconds: 10), onTimeout: () {
        print('DEBUG: user.reload() timed out');
      });

      final refreshedUser = _auth.currentUser!;
      print('DEBUG: emailVerified = ${refreshedUser.emailVerified}');

      if (!refreshedUser.emailVerified) {
        try {
          await refreshedUser.sendEmailVerification();
          print('DEBUG: Resent verification email');
        } catch (e) {
          print('DEBUG: Could not resend verification: $e');
        }
        await _auth.signOut();
        return {
          'success': false,
          'error':
              'Email not verified. A new link has been sent to $email. Check inbox/spam.',
        };
      }

      // Firestore update with timeout so it never hangs
      try {
        await _db
            .collection('users')
            .doc(refreshedUser.uid)
            .update({'emailVerified': true})
            .timeout(const Duration(seconds: 8));
        print('DEBUG: Firestore emailVerified updated');
      } catch (e) {
        // Don't block login if Firestore update fails
        print('DEBUG: Firestore update skipped: $e');
      }

      return {'success': true};
    } on FirebaseAuthException catch (e) {
      print('DEBUG: Login error [${e.code}]: ${e.message}');
      return {'success': false, 'error': getErrorMessage(e.code)};
    } catch (e) {
      print('DEBUG: Unexpected login error: $e');
      return {'success': false, 'error': 'An unexpected error occurred.'};
    }
  }
  // ✅ TO HERE

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static User? get currentUser => _auth.currentUser;

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
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'An error occurred [$code]. Please try again.';
    }
  }
}