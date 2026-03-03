import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/tips_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/app_icons.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';
import 'tips_and_tricks_description_screen.dart';

class TipsAndTricksScreen extends StatefulWidget {
  const TipsAndTricksScreen({super.key});

  @override
  State<TipsAndTricksScreen> createState() => _TipsAndTricksScreenState();
}

class _TipsAndTricksScreenState extends State<TipsAndTricksScreen>
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
    return ChangeNotifierProvider(
      create: (_) => TipsProvider(),
      builder: (context, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
              ).createShader(bounds),
              child: const Text(
                "PRO TIPS",
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
              child: Consumer<TipsProvider>(
                builder: (context, provider, child) {
                  final tips = provider.tips;
                  return SafeArea(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      itemCount: tips.length,
                      itemBuilder: (context, index) {
                        final TipsModel item = tips[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Stack(
                            children: [
                              AntigravityCard(
                                onTap: () async {
                                  await checkAdsAndOpenUrl(context)
                                      .then((value) => log("Link opened"))
                                      .catchError((error) =>
                                          log("Error opening link: $error"));

                                  if (!item.isAd) {
                                    Future.delayed(
                                        const Duration(milliseconds: 300), () {
                                      navigateWithAnimation(
                                          context,
                                          TipsAndTricksDescriptionScreen(
                                              title: item.title,
                                              description:
                                                  item.description ?? ""));
                                    });
                                  }
                                },
                                borderGradient: index % 2 == 0
                                    ? [
                                        const Color(0xFF48CAE4),
                                        const Color(0xFF5E60CE)
                                      ]
                                    : [
                                        const Color(0xFF9D4EDD),
                                        const Color(0xFF5E60CE)
                                      ],
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: (index % 2 == 0
                                                  ? AppColors.secondary
                                                  : AppColors.primary)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: (index % 2 == 0
                                                      ? AppColors.secondary
                                                      : AppColors.primary)
                                                  .withOpacity(0.3)),
                                        ),
                                        child: SvgPicture.asset(
                                          item.isAd
                                              ? AppIcons.playGame
                                              : AppIcons.tipsTricks,
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "TAP TO UNLOCK SECRETS",
                                              style: TextStyle(
                                                color: Colors.white38,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white24,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                              if (item.isAd)
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.amber.withOpacity(0.5),
                                          width: 1),
                                    ),
                                    child: const Text(
                                      'AD',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: const BanerAdsScreen(),
        );
      },
    );
  }
}
