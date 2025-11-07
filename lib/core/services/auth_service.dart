import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

/// Auth result class for handling authentication responses
class AuthResult {
  final bool isSuccess;
  final String? errorMessage;

  AuthResult._(this.isSuccess, this.errorMessage);

  factory AuthResult.success() => AuthResult._(true, null);
  factory AuthResult.failure(String error) => AuthResult._(false, error);
}

/// Authentication service handling Google and Apple sign-in
class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Configure GoogleSignIn with server client ID for Firebase Authentication
  // Server client ID (client_type: 3) from google-services.json: 7789770188-m3l1q2vub09s6atao2krdv5hompbrd33.apps.googleusercontent.com
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // Server client ID is required for Firebase Authentication
    // This is the Web client (OAuth 2.0) client ID from google-services.json
    serverClientId: '7789770188-m3l1q2vub09s6atao2krdv5hompbrd33.apps.googleusercontent.com',
  );

  /// Current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => currentUser != null;

  /// Sign in with Google
  /// Returns null if user cancels, throws exception on error
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in - return null (not an error)
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      // Handle platform-specific errors (common with Google Sign-In setup issues)
      throw Exception(_getPlatformErrorMessage(e));
    } on FirebaseAuthException catch (e) {
      // Re-throw Firebase auth exceptions with user-friendly messages
      // Create a new exception with the user-friendly message
      throw Exception(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      // Re-throw other exceptions with user-friendly message
      throw Exception(_getGenericErrorMessage(e));
    }
  }

  /// Sign in with Apple
  /// Returns null if user cancels, throws exception on error
  Future<UserCredential?> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      return userCredential;
    } on SignInWithAppleAuthorizationException catch (e) {
      // User cancelled or authorization failed
      // Check if user cancelled (code 1001) or other authorization errors
      if (e.code == AuthorizationErrorCode.canceled || 
          e.code == AuthorizationErrorCode.unknown) {
        // User cancelled - return null (not an error)
        return null;
      }
      // Re-throw other authorization errors with user-friendly message
      throw Exception('Apple Sign-In failed: ${e.message ?? "Please try again"}');
    } on FirebaseAuthException catch (e) {
      // Re-throw Firebase auth exceptions with user-friendly messages
      // Create a new exception with the user-friendly message
      throw Exception(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      // Re-throw other exceptions
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      print('Sign out error: $e');
      rethrow;
    }
  }

  /// Generate a random nonce for Apple Sign-In security
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Check if Apple Sign-In is available (iOS 13+)
  bool get isAppleSignInAvailable {
    if (Platform.isIOS) {
      return true; // Apple Sign-In is available on iOS 13+
    }
    return false;
  }

  /// Check if Google Sign-In is available
  bool get isGoogleSignInAvailable {
    return true; // Google Sign-In is available on both platforms
  }

  /// Get user display name
  String? get userDisplayName => currentUser?.displayName;

  /// Get user email
  String? get userEmail => currentUser?.email;

  /// Get user photo URL
  String? get userPhotoUrl => currentUser?.photoURL;

  /// Get user UID
  String? get userUid => currentUser?.uid;

  /// Check if email is verified
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  /// Sign up with email and password
  Future<UserCredential?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      return userCredential;
    } catch (e) {
      print('Email Sign-Up Error: $e');
      rethrow;
    }
  }

  /// Sign in with email and password
  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Email Sign-In Error: $e');
      rethrow;
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
    } catch (e) {
      print('Send email verification error: $e');
      rethrow;
    }
  }

  /// Reload user data
  Future<void> reloadUser() async {
    try {
      await currentUser?.reload();
    } catch (e) {
      print('Reload user error: $e');
      rethrow;
    }
  }

  /// Send password reset email
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult.success();
    } catch (e) {
      print('Password reset email error: $e');
      return AuthResult.failure(_getPasswordResetErrorMessage(e));
    }
  }

  /// Get user-friendly error message for password reset
  String _getPasswordResetErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No account found with this email address.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'network-request-failed':
          return 'Network error. Please check your connection.';
        default:
          return 'Failed to send password reset email. Please try again.';
      }
    }
    return 'An unexpected error occurred. Please try again.';
  }

  /// Get user-friendly error message for Firebase authentication errors
  String _getFirebaseAuthErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';
      case 'invalid-credential':
        return 'Invalid credentials. Please try again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No account found. Please sign up first.';
      default:
        return error.message ?? 'Authentication failed. Please try again.';
    }
  }

  /// Get user-friendly error message for PlatformException errors
  /// These typically occur due to configuration issues with Google Sign-In
  String _getPlatformErrorMessage(PlatformException error) {
    final code = error.code.toLowerCase();
    final message = error.message ?? '';

    // Common Google Sign-In platform errors
    if (code.contains('sign_in_failed') || 
        code.contains('sign_in_canceled') ||
        message.toLowerCase().contains('sign_in_failed')) {
      if (message.toLowerCase().contains('developer_error') ||
          code.contains('developer_error')) {
        return 'Google Sign-In configuration error. Please check:\n'
               '1. SHA-1 fingerprint is added to Firebase Console\n'
               '2. OAuth 2.0 Client ID is configured\n'
               '3. google-services.json is properly configured';
      }
      return 'Google Sign-In failed. Please try again.';
    }
    
    if (code.contains('network_error') || 
        message.toLowerCase().contains('network')) {
      return 'Network error. Please check your internet connection and try again.';
    }
    
    if (code.contains('api_not_available') || 
        message.toLowerCase().contains('api_not_available')) {
      return 'Google Sign-In is not available on this device. Please check your device settings.';
    }
    
    if (code.contains('developer_error') || 
        message.toLowerCase().contains('developer_error')) {
      return 'Google Sign-In configuration error. Please ensure:\n'
             '1. SHA-1 fingerprint is added to Firebase\n'
             '2. OAuth client is properly configured\n'
             '3. google-services.json is correct';
    }
    
    if (code.contains('invalid_account') || 
        message.toLowerCase().contains('invalid_account')) {
      return 'Invalid Google account. Please try a different account.';
    }

    // If we have a meaningful message, use it
    if (message.isNotEmpty && 
        !message.toLowerCase().contains('platformexception') &&
        message.length < 200) {
      return message;
    }
    
    // Default message with helpful information
    return 'Google Sign-In error occurred. This is usually due to:\n'
           '• Missing SHA-1 fingerprint in Firebase Console\n'
           '• Incorrect OAuth client configuration\n'
           '• Network connectivity issues\n\n'
           'Please check your Firebase configuration or try again.';
  }

  /// Get user-friendly error message for generic exceptions
  String _getGenericErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    // Check for common error patterns
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Network error. Please check your connection and try again.';
    }
    
    if (errorString.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    
    if (errorString.contains('configuration') || 
        errorString.contains('config')) {
      return 'Configuration error. Please check your Firebase setup.';
    }
    
    if (errorString.contains('permission') || 
        errorString.contains('denied')) {
      return 'Permission denied. Please check app permissions.';
    }
    
    // Return a generic message
    return 'An unexpected error occurred during sign-in. Please try again.';
  }

  /// Sign in with phone number
  Future<AuthResult> signInWithPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60),
      );
      return AuthResult.success();
    } catch (e) {
      print('Phone Sign-In Error: $e');
      return AuthResult.failure(e.toString());
    }
  }

  /// Verify phone number with OTP
  Future<AuthResult> verifyPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      return AuthResult.success();
    } catch (e) {
      print('Phone Verification Error: $e');
      return AuthResult.failure(e.toString());
    }
  }

  /// Update user display name
  Future<void> updateDisplayName(String displayName) async {
    try {
      await currentUser?.updateDisplayName(displayName);
      await reloadUser();
    } catch (e) {
      print('Update display name error: $e');
      rethrow;
    }
  }

  /// Upload profile photo to Firebase Storage
  Future<String?> uploadProfilePhoto(File imageFile) async {
    try {
      final user = currentUser;
      if (user == null) throw Exception('No user logged in');

      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_photos')
          .child('${user.uid}.jpg');

      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Upload profile photo error: $e');
      rethrow;
    }
  }

  /// Update user profile photo URL
  Future<void> updateProfilePhoto(String photoUrl) async {
    try {
      await currentUser?.updatePhotoURL(photoUrl);
      await reloadUser();
    } catch (e) {
      print('Update profile photo error: $e');
      rethrow;
    }
  }
}
