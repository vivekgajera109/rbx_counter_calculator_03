import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/spin_wheel_provider.dart';
import 'package:rbx_counter/Provider/wallet_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_dialog/common_dialog.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({super.key});

  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen>
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

  void _showResultDialog(BuildContext context, String result) {
    if (result != "0") {
      final wallet = Provider.of<WalletProvider>(context, listen: false);
      wallet.addReward(int.parse(result));
    }

    CommonDialog.show(
      context,
      success: result != "0",
      title: result != "0" ? "🎉 Congratulations!" : "😢 Try Again",
      message: result != "0"
          ? "You won $result RBX!\nTotal RBX: ${Provider.of<WalletProvider>(context, listen: false).totalReward}"
          : "This spin was not successful. Try again!",
      buttonText: result != "0" ? "Add Wallet" : "Retry",
      lottieAsset: result != "0" ? 'assets/lottie/Trophy.json' : null,
      onButtonPressed: () async {
        Navigator.pop(context);
        await checkAdsAndOpenUrl(context)
            .then((value) => log("Link opened"))
            .catchError((error) => log("Error opening link: $error"));
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpinWheelProvider>(
      builder: (context, provider, child) {
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
                "LUCKY WHEEL",
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Wallet Header
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

                      const SizedBox(height: 40),

                      // Fortune Wheel Container
                      Container(
                        height: 350,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF48CAE4).withOpacity(0.15),
                              blurRadius: 50,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: FortuneWheel(
                          onAnimationEnd: () {
                            _showResultDialog(context,
                                provider.items[provider.selected].toString());
                          },
                          selected: provider.selectedStream,
                          animateFirst: false,
                          duration: const Duration(seconds: 4),
                          hapticImpact: HapticImpact.medium,
                          physics: CircularPanPhysics(
                            duration: const Duration(seconds: 4),
                            curve: Curves.decelerate,
                          ),
                          styleStrategy: const UniformStyleStrategy(
                            borderColor: Colors.white24,
                            borderWidth: 2,
                          ),
                          items: [
                            for (var item in provider.items)
                              FortuneItem(
                                child: Text(
                                  item.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                style: FortuneItemStyle(
                                  color: provider.items.indexOf(item) % 2 == 0
                                      ? const Color(0xFF0D0D0D)
                                      : const Color(0xFF1A1A1A),
                                  borderColor:
                                      const Color(0xFF48CAE4).withOpacity(0.3),
                                  borderWidth: 1,
                                ),
                              ),
                          ],
                          indicators: const <FortuneIndicator>[
                            FortuneIndicator(
                              alignment: Alignment.topCenter,
                              child: TriangleIndicator(
                                color: Color(0xFF48CAE4),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Spin Button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: provider.isSpinning
                              ? null
                              : () => provider.spinWheel(),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: provider.isSpinning
                                    ? [
                                        Colors.grey.shade900,
                                        Colors.grey.shade800
                                      ]
                                    : [
                                        const Color(0xFF48CAE4),
                                        const Color(0xFF9D4EDD)
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: (provider.isSpinning
                                          ? Colors.transparent
                                          : const Color(0xFF48CAE4))
                                      .withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: provider.isSpinning
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 3),
                                  )
                                : const Text(
                                    "SPIN WHEEL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const NativeAdsScreen(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
