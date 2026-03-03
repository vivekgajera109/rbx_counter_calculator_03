import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/common/common_card/professional_card.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:rbx_counter/screen/calculator_screen.dart';
import '../Provider/calculator_provider.dart';

class AllCalculatorScren extends StatelessWidget {
  const AllCalculatorScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "All Calculator",
        showBackButton: true,
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
          final calculators = calculatorProvider.calculators;

          // Break calculators into chunks of 4 items
          final chunks = <List<CalculatorModel>>[];
          for (var i = 0; i < calculators.length; i += 4) {
            final end =
                (i + 4 < calculators.length) ? i + 4 : calculators.length;
            chunks.add(calculators.sublist(i, end));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: chunks.length * 2 - 1, // 4 items + 1 ad
            itemBuilder: (context, index) {
              if (index.isOdd) {
                // 🔹 Show Ad after every 4 items
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: NativeAdsScreen(),
                );
              }

              // 🔹 Show Grid of 4 calculators
              final chunkIndex = index ~/ 2;
              final chunk = chunks[chunkIndex];

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chunk.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1, // ✅ fix same size
                ),
                itemBuilder: (context, i) {
                  final model = chunk[i];
                  return GestureDetector(
                    onTap: () async {
                      if (model.title == "Play Game") {
                        await checkAdsAndOpenUrl(context)
                            .then((value) => log("Link opened"))
                            .catchError(
                                (error) => log("Error opening link: $error"));
                      } else {
                        await checkAdsAndOpenUrl(context)
                            .then((value) => log("Link opened"))
                            .catchError(
                                (error) => log("Error opening link: $error"));
                        Future.delayed(const Duration(seconds: 1), () {
                          navigateWithAnimation(
                            context,
                            CalculatorScreen(model: model),
                          );
                        });
                      }
                    },
                    child: ProfessionalCalulatorCard(card: model),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
