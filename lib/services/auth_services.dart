import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Registers a new user with email/password
  /// Returns the created User object if successful, null otherwise
  Future<User?> signUp(String email, String password) async {
    try {
      // Create user account
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logAuthError('SignUp', e);
      rethrow; // Let the UI handle specific error messages
    } catch (e) {
      print('Unexpected signup error: $e');
      rethrow;
    }
  }

  /// Signs in an existing user with email/password
  /// Returns the authenticated User if successful, null otherwise
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logAuthError('Login', e);
      rethrow;
    } catch (e) {
      print('Unexpected login error: $e');
      rethrow;
    }
  }

  /// Signs out the current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Logout error: $e');
      rethrow;
    }
  }

  /// Gets the currently authenticated user
  User? get currentUser => _auth.currentUser;

  /// Stream of authentication state changes
  Stream<User?> get userChanges => _auth.authStateChanges();

  /// Helper method for consistent error logging
  void _logAuthError(String operation, FirebaseAuthException e) {
    print('$operation failed: ${e.code} - ${e.message}');
    if (e.stackTrace != null) {
      print('Stack trace: ${e.stackTrace}');
    }
  }
}