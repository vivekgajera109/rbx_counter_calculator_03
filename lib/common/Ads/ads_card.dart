import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/ads_provider.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';

class NativeAdsScreen extends StatelessWidget {
  const NativeAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);

    if (!adsProvider.adsEnabled) {
      return const SizedBox.shrink(); // 🚫 Hide completely
    }

    final random = Random();
    final img =
        adsProvider.adsImages[random.nextInt(adsProvider.adsImages.length)];
    final logo =
        adsProvider.adsImages[random.nextInt(adsProvider.adsImages.length)];
    final title =
        adsProvider.adTitles[random.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[random.nextInt(adsProvider.adSubtitles.length)];
    final button = adsProvider
        .buttonTitles[random.nextInt(adsProvider.buttonTitles.length)];

    return GestureDetector(
      onTap: () async => await checkAdsAndOpenUrl(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(logo, width: 40, height: 40)),
              title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle:
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
              trailing: const Chip(label: Text("Ad")),
            ),
            Image.asset(img,
                width: double.infinity, height: 120, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CommonOutlineButton(
                onTap: () async => await checkAdsAndOpenUrl(context),
                title: button,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BanerAdsScreen extends StatelessWidget {
  const BanerAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);

    if (!adsProvider.adsEnabled) {
      return const SizedBox.shrink();
    }

    final r = Random();
    final logo = adsProvider.adsImages[r.nextInt(adsProvider.adsImages.length)];
    final title = adsProvider.adTitles[r.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[r.nextInt(adsProvider.adSubtitles.length)];
    final btn =
        adsProvider.buttonTitles[r.nextInt(adsProvider.buttonTitles.length)];

    return GestureDetector(
      onTap: () async => await checkAdsAndOpenUrl(context),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(logo, width: 50, height: 50)),
              title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle:
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
              trailing: const Chip(label: Text("Ad")),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CommonOutlineButton(
                title: btn,
                onTap: () async => await checkAdsAndOpenUrl(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
