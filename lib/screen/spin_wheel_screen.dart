import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/spin_wheel_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/common/common_dialog/common_dialog.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/static_decoration.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';

class SpinWheelScreen extends StatelessWidget {
  const SpinWheelScreen({super.key});

  // void _showResultDialog(BuildContext context, String result) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       title: const Text(
  //         '🎉 Congratulations!',
  //         style:
  //             TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
  //       ),
  //       content: Text(
  //         'You won: $result',
  //         style: const TextStyle(color: AppColors.textColor),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child:
  //               const Text("OK", style: TextStyle(color: AppColors.secondary)),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void _showResultDialog(BuildContext context, String result) {
    final provider = Provider.of<SpinWheelProvider>(context, listen: false);

    CommonDialog.show(
      context,
      success: result != "0", // true if non-zero
      title: result != "0" ? "🎉 Congratulations!" : "😢 Try Again",
      message: result != "0"
          ? "You won $result RBX!\nTotal RBX: ${provider.reward}"
          : "This card was not successful. Try again!",
      buttonText: result != "0" ? "Add Wallet" : "Retry",
      lottieAsset: result != "0" ? 'assets/lottie/Trophy.json' : null,
      onButtonPressed: () async {
        Navigator.pop(context);
        await checkAdsAndOpenUrl(context)
            .then(
              (value) => log("Link opened"),
            )
            .catchError(
              (error) => log("Error opening link: $error"),
            );
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SpinWheelProvider>();

    return Scaffold(
      bottomNavigationBar: BanerAdsScreen(),
      appBar: CommonAppBar(title: "Spin & Wheel", showBackButton: true),
      body: ListView(
        physics: BouncingScrollPhysics(),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          height10,
          CommonOutlineButton(
            radius: 0,
            title: "RBX Reward: ${provider.reward}",
            width: double.infinity,
            onTap: null,
          ),
          height20,

          height20,
          SizedBox(
            height: 300,
            child: FortuneWheel(
              onAnimationEnd: () {
                _showResultDialog(
                    context, provider.items[provider.selected].toString());
              },
              selected: provider.selectedStream, // stream from provider
              animateFirst: false,
              duration: const Duration(seconds: 4),

              hapticImpact: HapticImpact.medium,
              physics: CircularPanPhysics(
                duration: const Duration(seconds: 4),
                curve: Curves.decelerate,
              ),
              styleStrategy: UniformStyleStrategy(
                  borderColor: AppColors.white // border color
                  ,
                  borderWidth: 3 // border width
                  ),
              items: [
                for (var item in provider.items)
                  FortuneItem(
                    child: Text(
                      item.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                    style: FortuneItemStyle(
                      color: provider.items.indexOf(item) % 2 == 0
                          ? AppColors.primary
                          : AppColors.secondary, // alternate colors
                      borderColor: AppColors.white,
                      borderWidth: 3,
                    ),
                  ),
              ],
              indicators: const <FortuneIndicator>[
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: TriangleIndicator(color: AppColors.buttonsColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: provider.isSpinning
                ? Column(
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                    ],
                  )
                : CommonOutlineButton(
                    title: "Spin Now",
                    onTap:
                        provider.isSpinning ? null : () => provider.spinWheel(),
                  ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColors.buttonsColor,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          //   ),
          //   onPressed: provider.isSpinning ? null : () => provider.spinWheel(),
          //   child: provider.isSpinning
          //       ? const CircularProgressIndicator(color: AppColors.white)
          //       : const Text(
          //           '🎡 Spin Now',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: AppColors.white,
          //           ),
          //         ),
          // ),
        ],
      ),
    );
  }
}
