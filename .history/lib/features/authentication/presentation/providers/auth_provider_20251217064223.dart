import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/auth_service.dart';
import '../../../../core/utils/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false; // Used for general loading (signin/signup)
  String? _errorMessage;

  // New: specific flag to check if the valid session exists in storage
  bool _isSessionValid = false;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isSessionValid => _isSessionValid;

  AuthProvider() {
    // Listen to auth state changes from Firebase
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ---------------------------------------------------------
  // NEW METHOD: Check Secure Storage + Auth State
  // ---------------------------------------------------------
  Future<void> checkSecureStorageForLogin() async {
    try {
      _isLoading = true;
      notifyListeners();

      // 1. Read the login flag/token from your storage service
      // Note: Ensure your StorageService supports getString or similar
      final String? loggedInFlag = await StorageService.instance.getString(
        'is_logged_in',
      );

      // 2. Validate: We need both Firebase Auth User AND the Storage Flag
      if (_user != null && loggedInFlag == 'true') {
        _isSessionValid = true;
      } else {
        _isSessionValid = false;
      }
    } catch (e) {
      _isSessionValid = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------------------------------------------------------
  // Sign In
  // ---------------------------------------------------------
  Future<bool> signIn({required String email, required String password}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.signIn(email: email, password: password);

      // Update Storage: Save email and Login Flag
      await StorageService.instance.setString('last_email', email);
      await StorageService.instance.setString('is_logged_in', 'true');

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      return false;
    }
  }

  // ---------------------------------------------------------
  // Sign In with Google
  // ---------------------------------------------------------
  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signInWithGoogle();
      final email = credential.user?.email ?? _authService.currentUser?.email;

      if (email != null) {
        await StorageService.instance.setString('last_email', email);
      }

      // Update Storage: Save Login Flag
      await StorageService.instance.setString('is_logged_in', 'true');

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      return false;
    }
  }

  // Sign Up
  Future<bool> signUp({required String email, required String password}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.signUp(email: email, password: password);

      // Usually, SignUp also logs the user in immediately
      await StorageService.instance.setString('last_email', email);
      await StorageService.instance.setString('is_logged_in', 'true');

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      return false;
    }
  }

  // ---------------------------------------------------------
  // Sign Out
  // ---------------------------------------------------------
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.signOut();

      // Update Storage: Remove Login Flag
      await StorageService.instance.remove('is_logged_in');

      _isSessionValid = false; // Reset local validation flag

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to sign out';
      notifyListeners();
    }
  }

  // Reset Password
  Future<bool> resetPassword({required String email}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.resetPassword(email: email);

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to send reset email';
      notifyListeners();
      return false;
    }
  }

  // Update Username
  Future<bool> updateUsername({required String displayName}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.updateUsername(displayName: displayName);
      _user = _authService.currentUser; // Refresh user

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update username';
      notifyListeners();
      return false;
    }
  }

  // Reset Password from Current Password
  Future<bool> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.resetPasswordFromCurrentPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update password';
      notifyListeners();
      return false;
    }
  }

  // Delete Account
  Future<bool> deleteAccount({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.deleteAccount(email: email, password: password);

      // Remove storage on account deletion
      await StorageService.instance.remove('is_logged_in');
      _isSessionValid = false;

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to delete account';
      notifyListeners();
      return false;
    }
  }

  // Helper method to get user-friendly error messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      default:
        return 'Authentication failed. Please try again';
    }
  }
}
