import 'package:flutter/foundation.dart';
import 'package:rbx_counter/constants/app_icons.dart';

class CalculatorProvider extends ChangeNotifier {
  final List<CalculatorModel> calculators = [
    CalculatorModel(
      icon: AppIcons.sToR,
      title: "USD to RBX",
      subtitle: "Calculate is USD to RBX Value are converted",
      from: "USD",
      to: "RBX",
      rate: 100.0,
    ),
    CalculatorModel(
      icon: AppIcons.rToS,
      title: "RBX to USD",
      subtitle: "Calculate is RBX to USD Value are converted",
      from: "RBX",
      to: "USD",
      rate: 0.01,
    ),
    CalculatorModel(
      icon: AppIcons.rToS,
      title: "RBX to Dollar",
      subtitle: "Calculate is RBX to Dollar Value are converted",
      from: "RBX",
      to: "Dollar",
      rate: 0.01,
    ),
    CalculatorModel(
      icon: AppIcons.playGame,
      title: "Play Game",
      subtitle: "Play smart, Play hard",
      from: "Play Game",
      to: "Play Game",
      rate: 0.0,
      isGame: true,
    ),
    CalculatorModel(
      icon: AppIcons.rToS,
      title: "Dollar to RBX",
      subtitle: "Calculate is Dollar to RBX Value are converted",
      from: "Dollar",
      to: "RBX",
      rate: 100.0,
    ),
    CalculatorModel(
        icon: AppIcons.playGame,
        title: "Play Game",
        subtitle: "Play smart, Play hard",
        from: "Play Game",
        to: "Play Game",
        rate: 0.0,
        isGame: true),
    CalculatorModel(
      icon: AppIcons.bToR,
      title: "BC to RBX",
      subtitle: "Calculate is BC to RBX Value are converted",
      from: "BC",
      to: "RBX",
      rate: 15.0,
    ),
    CalculatorModel(
      icon: AppIcons.tToR,
      title: "TBC to RBX",
      subtitle: "Calculate is TBC to RBX Value are converted",
      from: "TBC",
      to: "RBX",
      rate: 35.0,
    ),
    CalculatorModel(
      icon: AppIcons.oToR,
      title: "OBC to RBX",
      subtitle: "Calculate is TBC to RBX Value are converted",
      from: "OBC",
      to: "RBX",
      rate: 60.0,
    ),
    CalculatorModel(
      icon: AppIcons.playGame,
      title: "Play Game",
      subtitle: "Play smart, Play hard",
      from: "Play Game",
      to: "Play Game",
      isGame: true,
      rate: 0.0,
    ),
  ];

  double convert(double value, CalculatorModel model) {
    return value * model.rate;
  }
}

class CalculatorModel {
  final String title;
  final String subtitle;
  final String icon;
  final bool? isGame;
  final String from;
  final String to;
  final double rate; // conversion rate

  CalculatorModel({
    required this.title,
    required this.subtitle,
    required this.from,
    this.isGame = false,
    required this.to,
    required this.rate,
    required this.icon,
  });
}
