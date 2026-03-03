import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Provider/ads_provider.dart';

class RemoteConfigService {
  /// Initialize Remote Config + Save result in Provider
  static Future<void> initialize(BuildContext context) async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 0), // 🔥 important
        ),
      );

      await remoteConfig.setDefaults({
        "ads_enabled": true,
        "app_url": "https://google.com",
      });

      await remoteConfig.fetchAndActivate();

      bool adsEnabled = remoteConfig.getBool("ads_enabled");
      Provider.of<AdsProvider>(context, listen: false)
          .setAdsEnabled(adsEnabled);

      debugPrint("🔥 RemoteConfig Updated: ads_enabled = $adsEnabled");
    } catch (e) {
      debugPrint("RemoteConfig Init Error: $e");
    }
  }
}

/// 🔹 Open URL ONLY if adsEnabled = true
Future<void> checkAdsAndOpenUrl(BuildContext context) async {
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    bool adsEnabled =
        Provider.of<AdsProvider>(context, listen: false).adsEnabled;

    if (!adsEnabled) {
      debugPrint("🚫 Ads OFF → URL Not Allowed");
      return;
    }

    String url = remoteConfig.getString("app_url");
    debugPrint("🌍 Opening URL: $url");

    final uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      debugPrint("❌ Cannot open URL: $url");
      return;
    }

    await launchUrl(
      uri,
      mode: LaunchMode.inAppBrowserView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
      ),
    );
  } catch (e) {
    debugPrint("Open URL Error: $e");
  }
}

/// 🔹 Intercepts Back Button and redirects to Ad URL before popping
class RedirectionScope extends StatelessWidget {
  final Widget child;
  const RedirectionScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final navigator = Navigator.of(context);
        await checkAdsAndOpenUrl(context);

        if (navigator.canPop()) {
          navigator.pop();
        }
      },
      child: child,
    );
  }
}
