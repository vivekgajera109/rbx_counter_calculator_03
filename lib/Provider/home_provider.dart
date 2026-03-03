import 'package:flutter/material.dart';
import 'package:rbx_counter/model/card_model.dart';
import 'package:rbx_counter/screen/all_calculator_screen.dart';
import 'package:rbx_counter/screen/meme_screen.dart';
import 'package:rbx_counter/screen/scratch_card_screen.dart';
import 'package:rbx_counter/screen/spin_wheel_screen.dart';
import 'package:rbx_counter/screen/tips_and_tricks_screen.dart';
import '../constants/app_icons.dart';
import '../screen/quiz_screen.dart';

class HomeProvider with ChangeNotifier {
  final List<CardModel> _items = [
    CardModel(
      icon: AppIcons.allCalculator,
      title: "All Calculator",
      subtitle: "All RBX Calculators",
      showAdsTag: false,
      destination: const AllCalculatorScreen(),
    ),
    CardModel(
      icon: AppIcons.playGame,
      title: "Play Game",
      subtitle: "Play smart, Play hard",
      showAdsTag: true,
    ),
    CardModel(
      icon: AppIcons.scratchCard,
      title: "Scratch Card",
      subtitle: "Scratch the card win a prize",
      showAdsTag: false,
      destination: const ScratchCardScreen(),
    ),
    CardModel(
      icon: AppIcons.quizTime,
      title: "Quiz Time",
      subtitle: "Play quiz and get amazing gifts",
      showAdsTag: false,
      destination: QuizScreen(), // Add your Quiz Screen here
    ),
    CardModel(
      icon: AppIcons.playGame,
      title: "Paly Game",
      subtitle: "Play smart, Play hard",
      showAdsTag: true,
    ),
    CardModel(
      icon: AppIcons.spinWheel,
      title: "Lucky Spin Wheel",
      subtitle: "Spin wheel and get amazing gifts",
      showAdsTag: false,
      destination: SpinWheelScreen(),
    ),
    CardModel(
      icon: AppIcons.meme,
      title: "Meme",
      subtitle: "Play meme sounds or visuals for quick humor",
      showAdsTag: false,
      destination: MemeScreen(),
    ),
    CardModel(
      icon: AppIcons.tipsTricks,
      title: "Tips & Tricks",
      subtitle: "Provide helpful shortcuts or advice instantly",
      showAdsTag: false,
      destination: TipsAndTricksScreen(),
    ),
  ];
  List<CardModel> get items => _items;

  final List<CardModel> _allCalculatorItem = [
    CardModel(
      icon: AppIcons.sToR,
      title: "USD to RBX",
      subtitle: "Calculate is USD to RBX Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.rToS,
      title: "RBX to USD",
      subtitle: "Calculate is RBX to USD Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.rToS,
      title: "RBX to Dollar",
      subtitle: "Calculate is RBX to Dollar Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.rToS,
      title: "Dollar to RBX",
      subtitle: "Calculate is Dollar to RBX Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.bToR,
      title: "BC to RBX",
      subtitle: "Calculate is BC to RBX Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.tToR,
      title: "TBC to RBX",
      subtitle: "Calculate is TBC to RBX Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.oToR,
      title: "OBC to RBX",
      subtitle: "Calculate is TBC to RBX Value are converted",
      showAdsTag: false,
    ),
    CardModel(
      icon: AppIcons.playGame,
      title: "Paly Game",
      subtitle: "Play smart, Play hard",
      showAdsTag: true,
    ),
  ];
  List<CardModel> get allCalculatorItem => _allCalculatorItem;
}
