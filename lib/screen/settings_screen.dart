import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/common/common_card/title_card.dart';
import 'package:rbx_counter/constants/app_icons.dart';
import 'package:rbx_counter/constants/static_decoration.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NativeAdsScreen(),
      appBar: CommonAppBar(
        title: "Settings",
        showBackButton: true,
      ),
      body: Column(
        children: [
          height15,
          TitelCard(
            onTap: () async {
              await checkAdsAndOpenUrl(context);
            },
            title: "Share App",
            icon: AppIcons.shareApp,
          ),
          TitelCard(
            onTap: () async {
              await checkAdsAndOpenUrl(context);
            },
            title: "Rate Us",
            icon: AppIcons.rateUs,
          ),
          TitelCard(
            onTap: () {
              checkAdsAndOpenUrl(context);
            },
            title: "Privacy Policy",
            icon: AppIcons.privacyPolicy,
          ),
        ],
      ),
    );
  }
}
