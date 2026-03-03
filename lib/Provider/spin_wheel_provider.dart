import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpinWheelProvider with ChangeNotifier {
  final List<int> items = [600, 475, 100, 300, 325, 0, 525, 400, 425, 225];

  // Make it broadcast to allow multiple listeners
  final StreamController<int> _controller = StreamController<int>.broadcast();
  Stream<int> get selectedStream => _controller.stream;

  int _selected = 0;
  bool _isSpinning = false;

  int _reward = 0; // total coins
  int get reward => _reward;

  int get selected => _selected;
  bool get isSpinning => _isSpinning;

  SpinWheelProvider() {
    _loadReward();
  }

  Future<void> _loadReward() async {
    final prefs = await SharedPreferences.getInstance();
    _reward = prefs.getInt("reward") ?? 0;
    notifyListeners();
  }

  Future<void> _saveReward() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("reward", _reward);
  }

  void spinWheel() {
    if (_isSpinning) return;

    _isSpinning = true;
    _selected = Random().nextInt(items.length);
    _controller.add(_selected); // 🎯 push new value to wheel
    notifyListeners();

    Future.delayed(const Duration(seconds: 4), () {
      // when spin stops
      final prize = items[_selected];
      _reward += prize; // add coins
      _saveReward();

      _isSpinning = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
