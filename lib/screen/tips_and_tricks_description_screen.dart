// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rbx_counter/common/common_app_bar/common_app_bar.dart';

import 'package:rbx_counter/constants/app_style.dart';

class TipsAndTricksDescriptionScreen extends StatelessWidget {
  final String title;
  final String description;
  const TipsAndTricksDescriptionScreen(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Tips & Tricks", showBackButton: true),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              title,
              style: AppTextStyle.bold20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              description,
              style: AppTextStyle.normalRegular15,
            ),
          ),
        ],
      ),
    );
  }
}
