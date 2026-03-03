// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/constants/app_icons.dart';
import 'package:rbx_counter/constants/static_decoration.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:rbx_counter/provider/home_provider.dart';
import 'package:rbx_counter/screen/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/common_card/professional_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalReward = 0;

  @override
  void initState() {
    super.initState();
    _loadReward();
  }

  Future<void> _loadReward() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalReward = prefs.getInt("reward") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      // bottomNavigationBar: AdsScreen(),
      appBar: CommonAppBar(
        title: "RBX Calculator",
        actions: [
          GestureDetector(
            onTap: () async {
              await checkAdsAndOpenUrl(context);

              navigateWithAnimation(context, const SettingScreen());
            },
            child: SvgPicture.asset(
              AppIcons.settings,
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          builder: (context, child) {
            final homeItems = context.watch<HomeProvider>().items;
            final int totalSections = (homeItems.length / 5).ceil();
            return Consumer<HomeProvider>(builder: (context, provider, child) {
              _loadReward();
              return Column(
                children: [
                  height10,
                  CommonOutlineButton(
                    radius: 0,
                    title: "RBX Reward: $totalReward",
                    width: double.infinity,
                    onTap: null,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: totalSections,
                      itemBuilder: (context, sectionIndex) {
                        // Get the items for this section
                        final startIndex = sectionIndex * 5;
                        final endIndex =
                            (startIndex + 5).clamp(0, homeItems.length);
                        final sectionItems =
                            homeItems.sublist(startIndex, endIndex);

                        // First item is full-width
                        final fullWidthItem =
                            sectionItems.isNotEmpty ? sectionItems[0] : null;
                        final gridItems = sectionItems.length > 1
                            ? sectionItems.sublist(1)
                            : [];

                        return Column(
                          children: [
                            if (fullWidthItem != null) ...[
                              ProfessionalCard(
                                card: fullWidthItem,
                                title: fullWidthItem.title,
                                subtitle: fullWidthItem.subtitle,
                                icon: fullWidthItem.icon,
                                showAdsTag: fullWidthItem.showAdsTag,
                                isFullWidth: true,
                              ),
                              height10,

                              /// 🔹 Ad show karo FullWidth item pachhi
                              const NativeAdsScreen(),
                              height10,
                            ],
                            if (gridItems.isNotEmpty)
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: gridItems.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1 / 1,
                                ),
                                itemBuilder: (context, index) {
                                  final item = gridItems[index];
                                  return ProfessionalCard(
                                    card: item,
                                    title: item.title,
                                    subtitle: item.subtitle,
                                    icon: item.icon,
                                    showAdsTag: item.showAdsTag,
                                    isFullWidth: false,
                                  );
                                },
                              ),
                            height10,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            });
          }),
    );
  }
}
