import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletProvider with ChangeNotifier {
  int _totalReward = 0;
  int get totalReward => _totalReward;

  WalletProvider() {
    loadReward();
  }

  Future<void> loadReward() async {
    final prefs = await SharedPreferences.getInstance();
    _totalReward = prefs.getInt("reward") ?? 0;
    notifyListeners();
  }

  Future<void> addReward(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    _totalReward += amount;
    await prefs.setInt("reward", _totalReward);
    notifyListeners();
  }
}
