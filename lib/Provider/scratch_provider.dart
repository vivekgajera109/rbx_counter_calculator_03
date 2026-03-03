import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScratchProvider extends ChangeNotifier {
  int scratchedCount = 0;
  int reward = 0;

  bool lastSuccess = false;
  int lastReward = 0;

  final Random _random = Random();

  ScratchProvider() {
    _loadData();
    _generateNextResult();
  }

  void _generateNextResult() {
    // 50% chance success
    lastSuccess = _random.nextBool();
    lastReward = lastSuccess ? (_random.nextInt(10) + 1) : 0; // 1-10 RBX
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    scratchedCount = prefs.getInt("scratchedCount") ?? 0;
    reward = prefs.getInt("reward") ?? 0;
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("scratchedCount", scratchedCount);
    await prefs.setInt("reward", reward);
  }

  void onScratchCompleted() {
    scratchedCount++;
    if (lastSuccess) {
      reward += lastReward;
    }
    _saveData();
    // _generateNextResult(); // prepare for next card
    notifyListeners();
  }

  void reset() {
    scratchedCount = 0;
    reward = 0;
    _generateNextResult();
    _saveData();
    notifyListeners();
  }
}
