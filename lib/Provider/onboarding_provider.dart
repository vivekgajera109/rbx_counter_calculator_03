import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rbx_counter/constants/app_colors.dart';

class OnboardingProvider extends ChangeNotifier {
  final LiquidController controller = LiquidController();

  int currentPage = 0;

  final pages = [
    OnboardingPage(
      title: "Welcome to RBX Counter",
      subtitle: "Track your RBX rewards and spin the wheel for exciting prizes!",
      lottieAsset: "assets/lottie/onboarding1.json",
      bgColor: AppColors.primary,
    ),
    OnboardingPage(
      title: "Scratch & Win",
      subtitle: "Scratch cards to win coins and grow your RBX wallet.",
      lottieAsset: "assets/lottie/onboarding2.json",
      bgColor: AppColors.secondary,
    ),
    OnboardingPage(
      title: "Stay Updated",
      subtitle: "Get the latest rewards, memes, and offers directly on your app.",
      lottieAsset: "assets/lottie/onboarding3.json",
      bgColor: Color(0xFFFFE29A),
    ),
  ];

  void updateCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  /// MARK: completeOnboarding
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
  }

  /// Check if onboarding is completed
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_done') ?? false;
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String lottieAsset;
  final Color bgColor;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.lottieAsset,
    required this.bgColor,
  });
}
