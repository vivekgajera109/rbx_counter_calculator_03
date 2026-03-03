import 'package:flutter/material.dart';

class AdsProvider extends ChangeNotifier {
  // 🔹 Firebase Remote Config control for ads
  bool adsEnabled = false;

  final List<String> _adsImages = List.generate(
    15,
    (index) => 'assets/ads/ads${index + 1}.jpg',
  );

  final List<String> _adTitles = [
    "New Redeem Codes Daily 📜💰",
    "Boost Your RBX Balance ⚡",
    "Exclusive Skins & Outfits 👕✨",
    "Double Rewards Today 🎁🔥",
    "Unlock Hidden Deals 🔑💎",
    "Free Spin Rewards 🎡🎁",
    "Limited Time RBX Bonus ⏳💵",
    "Top Offers for You ⭐",
  ];

  final List<String> _adSubtitles = [
    "Find working RBX codes every day",
    "Get free RBX with simple steps",
    "Grab limited-time offers now",
    "Spin & win bonus rewards instantly",
    "Hurry! Limited rewards available",
    "Earn RBX faster than ever",
    "Special discounts just for you",
    "Don’t miss today’s offer",
  ];

  final List<String> _buttonTitles = [
    "Redeem Now",
    "Claim Offer",
    "Get Reward",
    "Unlock Deal",
    "Start Earning",
    "Spin Now",
    "Try Free",
    "Shop Now",
  ];

  // 🔹 Getters
  List<String> get adsImages => _adsImages;
  List<String> get adTitles => _adTitles;
  List<String> get adSubtitles => _adSubtitles;
  List<String> get buttonTitles => _buttonTitles;

  // 🔹 Update adsEnabled from Remote Config
  void setAdsEnabled(bool value) {
    adsEnabled = value;
    notifyListeners(); // UI refresh
  }
}
