import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/static_decoration.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/screen/home_screen.dart';
import 'package:rbx_counter/Provider/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              LiquidSwipe(
                pages: onboardingProvider.pages.map((page) {
                  print(onboardingProvider.currentPage);
                  return Container(
                    // color: page.bgColor,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: onboardingProvider.currentPage == 0
                            ? [Color(0xFF1E3A8A), Color(0xFF2563EB)]
                            : onboardingProvider.currentPage == 1
                                ? [Color(0xFF3B82F6), Color(0xFF88BEFF)]
                                : [Color(0xFFF59E0B), Color(0xFFFFE29A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          width: double.infinity,
                          child: Lottie.asset(
                            page.lottieAsset,
                            fit: BoxFit.fill,
                            repeat: true,
                          ),
                        ),
                        height20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                enableLoop: false,
                positionSlideIcon: 0.5,
                liquidController: onboardingProvider.controller,
                onPageChangeCallback: (index) {
                  onboardingProvider.updateCurrentPage(index);
                },
                slideIconWidget: onboardingProvider.currentPage ==
                        onboardingProvider.pages.length - 1
                    ? null
                    : const Icon(Icons.arrow_back_ios, color: AppColors.white),
              ),
              Positioned(
                bottom: 40,
                left: 30,
                right: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await onboardingProvider.completeOnboarding();
                        pushAndRemoveUntilWithAnimation(
                            context, const HomeScreen());
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (onboardingProvider.currentPage ==
                            onboardingProvider.pages.length - 1) {
                          await onboardingProvider.completeOnboarding();
                          pushAndRemoveUntilWithAnimation(
                              context, const HomeScreen());
                        } else {
                          onboardingProvider.controller.animateToPage(
                            page: onboardingProvider.currentPage + 1,
                            duration: 700,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        onboardingProvider.currentPage ==
                                onboardingProvider.pages.length - 1
                            ? "Done"
                            : "Next",
                        style: TextStyle(
                          color: onboardingProvider
                              .pages[onboardingProvider.currentPage].bgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
