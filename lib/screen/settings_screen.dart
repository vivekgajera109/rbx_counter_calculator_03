import 'package:flutter/material.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
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
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () async {
            await checkAdsAndOpenUrl(context);
            if (context.mounted) Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
          ).createShader(bounds),
          child: const Text(
            "CORE SETTINGS",
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
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                const SizedBox(height: 10),

                // Header Branding
                _buildSectionHeader("SYSTEM PREFERENCES"),
                const SizedBox(height: 20),

                // Settings Cards
                _buildSettingCard(
                  onTap: () async => await checkAdsAndOpenUrl(context),
                  title: "SHARE APPLICATION",
                  subtitle: "Invite your friends to earn rewards",
                  icon: AppIcons.shareApp,
                  gradient: [const Color(0xFF48CAE4), const Color(0xFF5E60CE)],
                ),

                const SizedBox(height: 16),

                _buildSettingCard(
                  onTap: () async => await checkAdsAndOpenUrl(context),
                  title: "RATE PERFORMANCE",
                  subtitle: "Help us optimize your experience",
                  icon: AppIcons.rateUs,
                  gradient: [const Color(0xFF9D4EDD), const Color(0xFF5E60CE)],
                ),

                const SizedBox(height: 16),

                _buildSettingCard(
                  onTap: () async => await checkAdsAndOpenUrl(context),
                  title: "PRIVACY PROTOCOL",
                  subtitle: "Review our security data policy",
                  icon: AppIcons.privacyPolicy,
                  gradient: [const Color(0xFFFF5400), const Color(0xFFFF0000)],
                ),

                const SizedBox(height: 40),

                // Version Info
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: const Text(
                      "CORE VERSION 1.0.42",
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                const NativeAdsScreen(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: const Color(0xFF48CAE4),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard({
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required String icon,
    required List<Color> gradient,
  }) {
    return AntigravityCard(
      onTap: onTap,
      borderGradient: gradient,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: gradient.first.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gradient.first.withOpacity(0.3)),
              ),
              child: SvgPicture.asset(
                icon,
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white12, size: 14),
          ],
        ),
      ),
    );
  }
}
