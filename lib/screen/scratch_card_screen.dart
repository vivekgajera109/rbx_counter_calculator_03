import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/scratch_provider.dart';
import 'package:rbx_counter/Provider/wallet_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_dialog/common_dialog.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:scratcher/scratcher.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';

class ScratchCardScreen extends StatefulWidget {
  const ScratchCardScreen({super.key});

  @override
  State<ScratchCardScreen> createState() => _ScratchCardScreenState();
}

class _ScratchCardScreenState extends State<ScratchCardScreen>
    with SingleTickerProviderStateMixin {
  int currentCard = 1;
  bool isScratched = false;
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

  void _showResultDialog(BuildContext context) {
    final provider = Provider.of<ScratchProvider>(context, listen: false);

    if (provider.lastSuccess) {
      Provider.of<WalletProvider>(context, listen: false)
          .addReward(provider.lastReward);
    }

    CommonDialog.show(
      context,
      success: provider.lastSuccess,
      title: provider.lastSuccess ? "🎉 Congratulations!" : "😢 Try Again",
      message: provider.lastSuccess
          ? "You won ${provider.lastReward} RBX!\nTotal RBX: ${Provider.of<WalletProvider>(context, listen: false).totalReward}"
          : "This card was not successful. Try again!",
      buttonText: provider.lastSuccess ? "Add Wallet" : "Retry",
      lottieAsset: provider.lastSuccess ? 'assets/lottie/Trophy.json' : null,
      onButtonPressed: () {
        Navigator.pop(context);
        setState(() {
          isScratched = false;
          if (provider.lastSuccess) currentCard++;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildScratchCard(BuildContext context) {
    return Consumer<ScratchProvider>(
      builder: (context, provider, child) {
        String cardText = provider.lastSuccess
            ? "🎁 YOU WON +${provider.lastReward} RBX!"
            : "😢 NO LUCK THIS TIME. RETRY!";

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "SCRATCH THE AREA BELOW",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
            // Antigravity Container for Scratcher
            AntigravityCard(
              onTap: () {},
              borderGradient: const [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
              child: Padding(
                padding: const EdgeInsets.all(4.0), // Gap for the glow
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Scratcher(
                    brushSize: 50,
                    threshold: 50,
                    color: const Color(0xFF1A1A1A),
                    image: Image.asset("assets/images/scratch_card_cover.png",
                        fit: BoxFit.cover),
                    onThreshold: () {
                      if (!isScratched) {
                        provider.onScratchCompleted();
                        setState(() => isScratched = true);
                        _showResultDialog(context);
                      }
                    },
                    child: Container(
                      height: 220,
                      width: 320,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D0D0D),
                        image: provider.lastSuccess
                            ? const DecorationImage(
                                image: AssetImage(
                                    "assets/images/onboarding1.png"), // Using a holographic asset as background
                                opacity: 0.1,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ambient Glow
                          Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  (provider.lastSuccess
                                          ? const Color(0xFF48CAE4)
                                          : Colors.redAccent)
                                      .withOpacity(0.15),
                                  Colors.transparent,
                                ],
                                radius: 0.8,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                provider.lastSuccess
                                    ? Icons.auto_awesome_rounded
                                    : Icons.sentiment_very_dissatisfied_rounded,
                                color: provider.lastSuccess
                                    ? const Color(0xFF48CAE4)
                                    : Colors.white30,
                                size: 40,
                              ),
                              const SizedBox(height: 12),
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: provider.lastSuccess
                                      ? [
                                          const Color(0xFF48CAE4),
                                          const Color(0xFF9D4EDD)
                                        ]
                                      : [Colors.white, Colors.white54],
                                ).createShader(bounds),
                                child: Text(
                                  cardText.split('.').first.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: 24,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              if (provider.lastSuccess) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1)),
                                  ),
                                  child: const Text(
                                    "REWARD UNLOCKED",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Hint Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _hintIcon(Icons.auto_awesome_rounded),
                const SizedBox(width: 20),
                _hintIcon(Icons.touch_app_rounded),
                const SizedBox(width: 20),
                _hintIcon(Icons.currency_bitcoin_rounded),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _hintIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: Colors.white30, size: 24),
    );
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
            "LUCKY SCRATCH",
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
          child: ChangeNotifierProvider(
            create: (_) => ScratchProvider(),
            builder: (context, child) {
              return Consumer<ScratchProvider>(
                  builder: (context, provider, child) {
                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Premium Stats Header
                        AntigravityCard(
                          onTap: () {},
                          borderGradient: const [
                            Color(0xFFFF5400),
                            Color(0xFFFF0000)
                          ],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "CURRENT BALANCE",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "RBX WALLET",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${Provider.of<WalletProvider>(context).totalReward}",
                                  style: const TextStyle(
                                    color: Color(0xFFFF5400),
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildScratchCard(context),
                        const SizedBox(height: 30),
                        const NativeAdsScreen(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
