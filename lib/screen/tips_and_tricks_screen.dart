// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/tips_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/app_icons.dart';
import 'package:rbx_counter/constants/app_style.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'tips_and_tricks_description_screen.dart';

class TipsAndTricksScreen extends StatelessWidget {
  const TipsAndTricksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TipsProvider(),
        builder: (context, child) {
          final tips = context.watch<TipsProvider>().tips;
          return Scaffold(
            bottomNavigationBar: BanerAdsScreen(),
            appBar: CommonAppBar(title: "Tips & Tricks", showBackButton: true),
            body: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tips.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final TipsModel item = tips[index];
                return GestureDetector(
                  onTap: () async {
                    if (item.isAd) {
                      await checkAdsAndOpenUrl(context)
                          .then(
                            (value) => log("Link opened"),
                          )
                          .catchError(
                            (error) => log("Error opening link: $error"),
                          );
                    } else {
                      await checkAdsAndOpenUrl(context)
                          .then(
                            (value) => log("Link opened"),
                          )
                          .catchError(
                            (error) => log("Error opening link: $error"),
                          );

                      Future.delayed(const Duration(seconds: 1), () {
                        navigateWithAnimation(
                            context,
                            TipsAndTricksDescriptionScreen(
                                title: item.title,
                                description: item.description ?? ""));
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            item.isAd ? AppIcons.playGame : AppIcons.tipsTricks,
                            color: AppColors
                                .white, //item.isAd ? AppColors.secondary : AppColors.primary,
                            width: 28,
                            height: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        if (item.isAd)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Ad',
                                style: AppTextStyle.normalRegular12
                                    .copyWith(color: AppColors.white)),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
