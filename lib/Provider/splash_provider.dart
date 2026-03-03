import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  SplashProvider() {
    _startSplash();
  }

  void _startSplash() {
    Timer(const Duration(seconds: 3), () {
      _isLoading = false;
      notifyListeners();
    });
  }
}
