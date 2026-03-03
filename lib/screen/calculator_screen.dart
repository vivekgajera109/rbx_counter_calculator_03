import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/calculator_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';

class CalculatorScreen extends StatefulWidget {
  final CalculatorModel model;

  const CalculatorScreen({super.key, required this.model});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController controller = TextEditingController();
  double? result;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CalculatorProvider>();

    return Scaffold(
      bottomNavigationBar: NativeAdsScreen(),
      // appBar: AppBar(
      //   title: Text(widget.model.title),
      // ),
      appBar: CommonAppBar(title: widget.model.title, showBackButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter your ${widget.model.from}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter ${widget.model.from}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              CommonOutlineButton(
                onTap: () {
                  final value = double.tryParse(controller.text) ?? 0.0;
                  setState(() {
                    result = provider.convert(value, widget.model);
                  });
                },
                title: 'Convert to ${widget.model.to}',
                // child: Text("Convert to ${widget.model.to}"),
              ),
              if (result != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  // margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    spacing: 10,
                    children: [
                      Text(
                        "Convert ${widget.model.to} Amount",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "${result?.toDouble()} ${widget.model.to}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      CommonOutlineButton(
                        onTap: () async {
                          await checkAdsAndOpenUrl(context)
                              .then(
                                (value) => log("Link opened"),
                              )
                              .catchError(
                                (error) => log("Error opening link: $error"),
                              );
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              result = null;
                              controller.clear();
                              Navigator.pop(context);
                            });
                          });
                        },
                        title: 'Done',
                        // child: Text("Reset"),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
