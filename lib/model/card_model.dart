// i need model class for home screen data is icon title subtitle and ads tag show or not
import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final String subtitle;
  final String icon;
  final bool showAdsTag;
  final Widget? destination;

  CardModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.showAdsTag,
    this.destination,
  });
}
