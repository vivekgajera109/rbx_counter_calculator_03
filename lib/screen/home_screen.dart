import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<bool?> _showExitDialog(BuildContext context) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Exit Dialog',
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = Curves.elasticOut.transform(anim1.value);
        return Transform.scale(
          scale: curve,
          child: Opacity(
            opacity: anim1.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D0D0D),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFFF5400).withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5400).withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.exit_to_app_rounded,
                        color: Color(0xFFFF5400), size: 60),
                    const SizedBox(height: 16),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFF5400), Color(0xFFFF0000)],
                      ).createShader(bounds),
                      child: const Text(
                        "EXIT INITIATED",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Are you sure you want to disconnect from the hub?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context, false),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.2)),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "CANCEL",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await checkAdsAndOpenUrl(context);
                              if (context.mounted) Navigator.pop(context, true);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF5400),
                                    Color(0xFFFF0000)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF5400)
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "CONFIRM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _showExitDialog(context) ?? false;
        if (shouldPop) {
          if (context.mounted) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
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
                                  child: _buildGridItem(context,
                                      homeItems[item1Index], item1Index),
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
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, dynamic item, int index) {
    return AntigravityCard(
      onTap: () async {
        await checkAdsAndOpenUrl(context);
        if (item.destination != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            navigateWithAnimation(context, item.destination!);
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
