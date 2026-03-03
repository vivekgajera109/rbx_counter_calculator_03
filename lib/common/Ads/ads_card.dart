import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/ads_provider.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import '../../presentation/widgets/antigravity_card.dart';

class NativeAdsScreen extends StatelessWidget {
  const NativeAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);

    if (!adsProvider.adsEnabled) {
      return const SizedBox.shrink();
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

    return AntigravityCard(
      onTap: () async => await checkAdsAndOpenUrl(context),
      borderGradient: const [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(logo,
                      width: 45, height: 45, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5), fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Text(
                    "AD",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 8,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                child: Image.asset(
                  img,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: CommonButton(
                  title: button,
                  height: 45,
                  margin: EdgeInsets.zero,
                  borderRadius: 12,
                  onPressed: () async => await checkAdsAndOpenUrl(context),
                ),
              ),
            ],
          ),
        ],
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

    return AntigravityCard(
      onTap: () async => await checkAdsAndOpenUrl(context),
      borderGradient: const [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
                  Image.asset(logo, width: 50, height: 50, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: CommonButton(
                title: btn,
                height: 35,
                margin: EdgeInsets.zero,
                borderRadius: 8,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
                onPressed: () async => await checkAdsAndOpenUrl(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
