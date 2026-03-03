// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rbx_counter/Provider/onboarding_provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:rbx_counter/screen/home_screen.dart';
import 'package:rbx_counter/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted || _navigated) return;
    _navigated = true;

    final onboardingDone = await OnboardingProvider.isOnboardingCompleted();

    await checkAdsAndOpenUrl(context);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            onboardingDone ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              height: 150,
              image: AssetImage('assets/icons/app_logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
