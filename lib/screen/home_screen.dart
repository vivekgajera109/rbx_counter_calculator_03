import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/home_provider.dart';
import 'package:rbx_counter/Provider/wallet_provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/screen/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
          ).createShader(bounds),
          child: const Text(
            "RBX COUNTER",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: Colors.white, size: 28),
            onPressed: () =>
                navigateWithAnimation(context, const SettingScreen()),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CyberBackground(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              final homeItems = provider.items;
              return SafeArea(
                bottom: false,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 10),
                    // Hero Banner / Dashboard
                    AntigravityCard(
                      onTap: () {},
                      borderGradient: [
                        const Color(0xFFFF5400),
                        const Color(0xFFFF0000)
                      ],
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "HUB STATUS: OPTIMAL",
                                    style: TextStyle(
                                      color: Color(0xFFFF5400),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${Provider.of<WalletProvider>(context).totalReward} RBX",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const Text(
                                    "WALLET BALANCE",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    const Color(0xFFFF5400).withOpacity(0.15),
                                border: Border.all(
                                    color: const Color(0xFFFF5400), width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF5400)
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.flash_on_rounded,
                                  color: Color(0xFFFF5400), size: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "CORE SYSTEMS",
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
                      itemCount: ((homeItems.length / 2).ceil()) +
                          ((homeItems.length / 4).floor()),
                      itemBuilder: (context, index) {
                        // Check if this position is for an Ad (after every 2 rows)
                        if ((index + 1) % 3 == 0) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: NativeAdsScreen(),
                          );
                        }

                        // Calculate actual row index for data
                        int adOffset = (index / 3).floor();
                        int rowIndex = index - adOffset;
                        int item1Index = rowIndex * 2;
                        int item2Index = rowIndex * 2 + 1;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First Item in Row
                              Expanded(
                                child: _buildGridItem(
                                    context, homeItems[item1Index], item1Index),
                              ),
                              const SizedBox(width: 16),
                              // Second Item in Row (if exists)
                              Expanded(
                                child: item2Index < homeItems.length
                                    ? _buildGridItem(context,
                                        homeItems[item2Index], item2Index)
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, dynamic item, int index) {
    return AntigravityCard(
      onTap: () {
        if (item.showAdsTag == true) {
          checkAdsAndOpenUrl(context);
        } else if (item.destination != null) {
          navigateWithAnimation(context, item.destination!);
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
