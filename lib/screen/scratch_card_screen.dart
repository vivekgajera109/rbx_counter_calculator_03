// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/scratch_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/common/common_dialog/common_dialog.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/static_decoration.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCardScreen extends StatefulWidget {
  const ScratchCardScreen({super.key});

  @override
  State<ScratchCardScreen> createState() => _ScratchCardScreenState();
}

class _ScratchCardScreenState extends State<ScratchCardScreen> {
  int currentCard = 1;
  bool isScratched = false;

  void _showResultDialog(BuildContext context) {
    final provider = Provider.of<ScratchProvider>(context, listen: false);
    provider.onScratchCompleted();

    CommonDialog.show(
      context,
      success: provider.lastSuccess,
      title: provider.lastSuccess ? "🎉 Congratulations!" : "😢 Try Again",
      message: provider.lastSuccess
          ? "You won ${provider.lastReward} RBX!\nTotal RBX: ${provider.reward}"
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
            ? "🎁 You won +${provider.lastReward} RBX!"
            : "😢 Sorry, No RBX this time. Try again!";
        return Scratcher(
          image: Image.asset(
              "assets/icons/scratch_overlay.jpeg"), // remove default overlay if using color
          brushSize: 40,
          threshold: 50,
          color: AppColors.background, // Scratch overlay color
          onThreshold: () {
            if (!isScratched) {
              provider.onScratchCompleted();
              setState(() => isScratched = true);
              _showResultDialog(context);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 220,
            width: 320,
            decoration: BoxDecoration(
              gradient: provider.lastSuccess
                  ? LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.subTextColor.withOpacity(0.3),
                        AppColors.textColor.withOpacity(0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              cardText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: provider.lastSuccess
                    ? AppColors.buttonsColor
                    : AppColors.textColor,
                fontSize: 20,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: AppColors.subTextColor.withOpacity(0.4),
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NativeAdsScreen(),
      // backgroundColor: Colors.blue.shade50,
      appBar: CommonAppBar(title: "Scratch Card", showBackButton: true),
      body: ChangeNotifierProvider(
        create: (_) => ScratchProvider(),
        builder: (context, child) {
          return Consumer<ScratchProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                height10,
                CommonOutlineButton(
                  radius: 0,
                  title: "RBX Reward: ${provider.reward}",
                  width: double.infinity,
                  onTap: null,
                ),
                const SizedBox(height: 20),
                Expanded(child: _buildScratchCard(context)),
              ],
            );
          });
        },
      ),
    );
  }
}
