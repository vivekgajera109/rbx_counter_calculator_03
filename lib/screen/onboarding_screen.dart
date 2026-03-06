import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/screen/home_screen.dart';
import 'package:rbx_counter/Provider/onboarding_provider.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: CyberBackground(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Skip Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          await provider.completeOnboarding();
                          pushAndRemoveUntilWithAnimation(
                              context, const HomeScreen());
                        },
                        child: Text(
                          "SKIP SYSTEM",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: provider.pages.length,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemBuilder: (context, index) {
                        final page = provider.pages[index];
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Lottie Display inside a premium container
                                Container(
                                  height: 280,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: (index == 0
                                                ? const Color(0xFF48CAE4)
                                                : index == 1
                                                    ? const Color(0xFF9D4EDD)
                                                    : const Color(0xFFFF5400))
                                            .withOpacity(0.1),
                                        blurRadius: 100,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    page.imageAsset,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // Content Card
                                AntigravityCard(
                                  onTap: () {},
                                  borderGradient: index == 0
                                      ? [
                                          const Color(0xFF48CAE4),
                                          const Color(0xFF5E60CE)
                                        ]
                                      : index == 1
                                          ? [
                                              const Color(0xFF9D4EDD),
                                              const Color(0xFF5E60CE)
                                            ]
                                          : [
                                              const Color(0xFFFF5400),
                                              const Color(0xFFFF0000)
                                            ],
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          page.title.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          page.subtitle,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 14,
                                            height: 1.6,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Bottom Controls
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        // Page Indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            provider.pages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 6,
                              width: _currentPage == index ? 24 : 6,
                              decoration: BoxDecoration(
                                gradient: _currentPage == index
                                    ? const LinearGradient(colors: [
                                        Color(0xFF48CAE4),
                                        Color(0xFF9D4EDD)
                                      ])
                                    : null,
                                color: _currentPage == index
                                    ? null
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Action Button
                        GestureDetector(
                          onTap: () async {
                            if (_currentPage == provider.pages.length - 1) {
                              await provider.completeOnboarding();
                              pushAndRemoveUntilWithAnimation(
                                  context, const HomeScreen());
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOutCubic,
                              );
                            }
                          },
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
                              ),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF48CAE4).withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _currentPage == provider.pages.length - 1
                                  ? "INITIALIZE"
                                  : "NEXT PROTOCOL",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
