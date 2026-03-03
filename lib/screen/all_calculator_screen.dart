import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:rbx_counter/screen/calculator_screen.dart';
import '../Provider/calculator_provider.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';
import '../common/Ads/ads_card.dart';

class AllCalculatorScreen extends StatefulWidget {
  const AllCalculatorScreen({super.key});

  @override
  State<AllCalculatorScreen> createState() => _AllCalculatorScreenState();
}

class _AllCalculatorScreenState extends State<AllCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation =
        CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic);
    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
          ).createShader(bounds),
          child: const Text(
            "ALL CALCULATORS",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: CyberBackground(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<CalculatorProvider>(
            builder: (context, provider, child) {
              final calculators = provider.calculators;
              return SafeArea(
                bottom: false,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 10),
                    // Banner Card
                    AntigravityCard(
                      onTap: () {},
                      borderGradient: [
                        const Color(0xFF48CAE4),
                        const Color(0xFF00D1FF)
                      ],
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "CONVERTER HUB",
                                    style: TextStyle(
                                      color: Color(0xFF48CAE4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "RBX TOOLS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.calculate_outlined,
                                color: Color(0xFF48CAE4), size: 45),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "SCANNER SYSTEMS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Dynamic Grid with Ads every 2 rows
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ((calculators.length / 2).ceil()) +
                          ((calculators.length / 4).floor()),
                      itemBuilder: (context, index) {
                        if ((index + 1) % 3 == 0) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: NativeAdsScreen(),
                          );
                        }

                        int adOffset = (index / 3).floor();
                        int rowIndex = index - adOffset;
                        int item1Index = rowIndex * 2;
                        int item2Index = rowIndex * 2 + 1;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildCalcItem(context,
                                    calculators[item1Index], item1Index),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: item2Index < calculators.length
                                    ? _buildCalcItem(context,
                                        calculators[item2Index], item2Index)
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: NativeAdsScreen(),
                    ),
                    const SizedBox(height: 120), // Spacer for bottom nav
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCalcItem(BuildContext context, dynamic item, int index) {
    return AntigravityCard(
      onTap: () {
        if (item.isGame == true) {
          checkAdsAndOpenUrl(context);
        } else {
          checkAdsAndOpenUrl(context);
          Future.delayed(const Duration(milliseconds: 300), () {
            navigateWithAnimation(context, CalculatorScreen(model: item));
          });
        }
      },
      borderGradient: index % 2 == 0
          ? [const Color(0xFF9D4EDD), const Color(0xFF5E60CE)]
          : [const Color(0xFF48CAE4), const Color(0xFF5E60CE)],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: (index % 2 == 0
                            ? AppColors.primary
                            : AppColors.secondary)
                        .withOpacity(0.2),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                item.icon,
                height: 32,
                width: 32,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              item.subtitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
