// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/meme_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/constants/app_style.dart';
import 'package:share_plus/share_plus.dart';

class MemeScreen extends StatelessWidget {
  const MemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final memes = context.watch<MemeProvider>().memes;

    return ChangeNotifierProvider(
      create: (_) => MemeProvider(),
      builder: (context, child) {
        return Consumer<MemeProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: CommonAppBar(title: "Memes", showBackButton: true),
              body: ListView.builder(
                itemCount: provider.memes.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  if ((index + 1) % 4 == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: const BanerAdsScreen(),
                    );
                  }
                  final meme = provider.memes[index]; // memes[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Meme title + description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meme.title,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                meme.description,
                                style: AppTextStyle.normalRegular12.copyWith(
                                    color: AppColors.white.withOpacity(0.9)),
                              ),
                            ],
                          ),
                        ),

                        // Share button
                        InkWell(
                          onTap: () {
                            final String content =
                                "${meme.title}\n\n${meme.description}"; // 👈 Title + Description

                            Share.share(
                              content,
                              subject: meme
                                  .title, // subject optional che (email apps ma use thay)
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.share,
                                color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
