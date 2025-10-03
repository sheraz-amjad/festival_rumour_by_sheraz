import 'package:flutter/foundation.dart';

/// Base ViewModel class that provides common functionality for all ViewModels
/// Implements ChangeNotifier for state management
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  String? _errorMessage;
  bool _busy = false;
  bool get busy => _busy;

  /// Current loading state
  bool get isLoading => _isLoading;

  /// Current error message
  String? get errorMessage => _errorMessage;

  /// Check if the ViewModel has been disposed
  bool get isDisposed => _isDisposed;

  /// Set loading state and notify listeners
  void setLoading(bool loading) {
    if (_isDisposed) return;
    
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message and notify listeners
  void setError(String? error) {
    if (_isDisposed) return;
    
    _errorMessage = error;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    if (_isDisposed) return;
    
    _errorMessage = null;
    notifyListeners();
  }

  /// Set both loading and error states
  void setState({bool? loading, String? error}) {
    if (_isDisposed) return;
    
    if (loading != null) {
      _isLoading = loading;
    }
    if (error != null) {
      _errorMessage = error;
    }
    notifyListeners();
  }

  /// Handle async operations with automatic loading state management
  Future<T?> handleAsync<T>(
    Future<T> Function() operation, {
    bool showLoading = true,
    String? errorMessage,
    void Function(String error)? onError,
  }) async {
    try {
      if (showLoading) setLoading(true);
      clearError();
      
      final result = await operation();
      
      if (showLoading) setLoading(false);
      return result;
    } catch (e) {
      if (showLoading) setLoading(false);
      
      final error = errorMessage ?? e.toString();
      setError(error);
      
      if (onError != null) {
        onError(error);
      }
      
      // Log error in debug mode
      if (kDebugMode) {
        print('Error in ${runtimeType}: $error');
      }
      
      return null;
    }
  }

  /// Initialize the ViewModel
  /// Override this method to perform initialization logic
  void init() {
    // Override in subclasses
  }

  /// Called when the ViewModel is being disposed
  /// Override this method to perform cleanup
  void onDispose() {
    // Override in subclasses
  }

  @override
  void dispose() {
    _isDisposed = true;
    onDispose();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  void setBusy(bool val) {
    _busy = val;
    notifyListeners();
  }
}





