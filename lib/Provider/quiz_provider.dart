import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProvider extends ChangeNotifier {
  int currentIndex = 0;
  int score = 0;
  bool isCompleted = false;
  String? selectedOption;

  final List<Question> allQuestions = [
    Question(
      question: "What year was Roblox officially released?",
      options: ["2004", "2006", "2008", "2010"],
      correctAnswer: "2006",
    ),
    Question(
      question: "Which currency is used in Roblox?",
      options: ["Robux", "Coins", "Gems", "Tickets"],
      correctAnswer: "Robux",
    ),
    Question(
      question: "Who is the founder of Roblox?",
      options: [
        "Mark Zuckerberg",
        "David Baszucki",
        "Evan Spiegel",
        "Phil Spencer"
      ],
      correctAnswer: "David Baszucki",
    ),
    Question(
      question: "Which Roblox game is known for its obbies?",
      options: ["Adopt Me", "Brookhaven", "Tower of Hell", "Bloxburg"],
      correctAnswer: "Tower of Hell",
    ),
    Question(
      question: "What is Roblox Studio used for?",
      options: [
        "Playing games",
        "Creating games",
        "Buying Robux",
        "Watching videos"
      ],
      correctAnswer: "Creating games",
    ),
    Question(
      question: "Which Roblox game lets you roleplay as pets?",
      options: ["Adopt Me", "Jailbreak", "Murder Mystery 2", "Bloxburg"],
      correctAnswer: "Adopt Me",
    ),
    Question(
      question: "What type of platform is Roblox?",
      options: [
        "Game creation system",
        "Video streaming",
        "Social media",
        "Music app"
      ],
      correctAnswer: "Game creation system",
    ),
    Question(
      question: "What do you need to trade items on Roblox?",
      options: ["Premium membership", "Level 50", "5 Robux", "Special code"],
      correctAnswer: "Premium membership",
    ),
    Question(
      question: "Which Roblox game is famous for its police vs. robber theme?",
      options: ["Adopt Me", "Jailbreak", "Tower of Hell", "Brookhaven"],
      correctAnswer: "Jailbreak",
    ),
    Question(
      question:
          "Which Roblox game focuses on building your own house and living simulation?",
      options: ["Bloxburg", "Tower of Hell", "Adopt Me", "Murder Mystery 2"],
      correctAnswer: "Bloxburg",
    ),
    Question(
      question: "Which Roblox event features virtual concerts?",
      options: [
        "Bloxy Awards",
        "Roblox Concerts",
        "RBC Festival",
        "Roblox Music"
      ],
      correctAnswer: "Roblox Concerts",
    ),
    Question(
      question: "What is the default avatar in Roblox called?",
      options: ["Noob", "Guest", "Builderman", "Roblo"],
      correctAnswer: "Noob",
    ),
    Question(
      question:
          "Which Roblox game involves solving mysteries and finding the murderer?",
      options: ["Murder Mystery 2", "Tower of Hell", "Adopt Me", "Jailbreak"],
      correctAnswer: "Murder Mystery 2",
    ),
    Question(
      question:
          "Which Roblox feature allows you to earn Robux by selling items?",
      options: [
        "Developer Exchange",
        "Robux Trade",
        "Roblox Market",
        "Avatar Shop"
      ],
      correctAnswer: "Developer Exchange",
    ),
    Question(
      question: "Roblox was founded in which year?",
      options: ["2000", "2004", "2006", "2008"],
      correctAnswer: "2004",
    ),
    Question(
      question: "Which Roblox game is popular for tycoon-style gameplay?",
      options: ["Restaurant Tycoon", "Tower of Hell", "Adopt Me", "Brookhaven"],
      correctAnswer: "Restaurant Tycoon",
    ),
    Question(
      question: "Which feature lets you customize your Roblox avatar?",
      options: ["Avatar Shop", "Robux Vault", "Game Pass", "Experience Points"],
      correctAnswer: "Avatar Shop",
    ),
    Question(
      question: "What is the Roblox event held annually to celebrate creators?",
      options: ["Bloxy Awards", "Roblox Fest", "Creator Day", "Roblox Expo"],
      correctAnswer: "Bloxy Awards",
    ),
    Question(
      question:
          "Which Roblox game lets you explore a virtual world with friends?",
      options: ["Brookhaven", "Tower of Hell", "Adopt Me", "Murder Mystery 2"],
      correctAnswer: "Brookhaven",
    ),
    Question(
      question: "Which Roblox game is known for simulator-style gameplay?",
      options: [
        "Bee Swarm Simulator",
        "Jailbreak",
        "Adopt Me",
        "Tower of Hell"
      ],
      correctAnswer: "Bee Swarm Simulator",
    ),
    Question(
      question: "Which Roblox game involves cooking and managing a restaurant?",
      options: ["Restaurant Tycoon 2", "Adopt Me", "Tower of Hell", "Bloxburg"],
      correctAnswer: "Restaurant Tycoon 2",
    ),
    Question(
      question: "Which Roblox game lets you adopt and take care of pets?",
      options: ["Adopt Me", "Tower of Hell", "Brookhaven", "Murder Mystery 2"],
      correctAnswer: "Adopt Me",
    ),
    Question(
      question: "What Roblox feature allows you to create private servers?",
      options: ["VIP Servers", "Game Pass", "Robux Servers", "Friends Server"],
      correctAnswer: "VIP Servers",
    ),
    Question(
      question: "Which Roblox game involves parkour challenges?",
      options: ["Tower of Hell", "Adopt Me", "Bloxburg", "Brookhaven"],
      correctAnswer: "Tower of Hell",
    ),
    Question(
      question: "Which Roblox game is focused on murder mystery gameplay?",
      options: ["Murder Mystery 2", "Adopt Me", "Brookhaven", "Jailbreak"],
      correctAnswer: "Murder Mystery 2",
    ),
    Question(
      question:
          "Which Roblox game is designed for roleplay in a town environment?",
      options: ["Brookhaven", "Tower of Hell", "Adopt Me", "Bloxburg"],
      correctAnswer: "Brookhaven",
    ),
    Question(
      question:
          "Which Roblox game lets you build and sell your own virtual items?",
      options: ["Roblox Studio", "Adopt Me", "Tower of Hell", "Brookhaven"],
      correctAnswer: "Roblox Studio",
    ),
    Question(
      question: "Which Roblox game is known for its racing gameplay?",
      options: [
        "Vehicle Simulator",
        "Adopt Me",
        "Bloxburg",
        "Murder Mystery 2"
      ],
      correctAnswer: "Vehicle Simulator",
    ),
    Question(
      question: "Which Roblox game lets you train pets and collect items?",
      options: ["Pet Simulator X", "Tower of Hell", "Brookhaven", "Adopt Me"],
      correctAnswer: "Pet Simulator X",
    ),
    Question(
      question:
          "Which Roblox game allows players to roleplay as different jobs and activities?",
      options: ["Bloxburg", "Adopt Me", "Tower of Hell", "Brookhaven"],
      correctAnswer: "Bloxburg",
    ),
  ];

  late List<Question> questions;

  QuizProvider() {
    _generateRandomQuestions();
  }

  void _generateRandomQuestions() {
    allQuestions.shuffle();
    questions = allQuestions.take(10).toList();
  }

  Future<void> answerQuestion(String option) async {
    selectedOption = option;

    if (questions[currentIndex].correctAnswer == option) {
      score++;
    }

    notifyListeners();

    Timer(const Duration(seconds: 1), () async {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        selectedOption = null;
      } else {
        isCompleted = true;

        // Calculate reward (10 per correct answer)
        int rewardEarned = score * 10;

        // Store reward in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int currentReward = prefs.getInt("reward") ?? 0;
        await prefs.setInt("reward", currentReward + rewardEarned);
      }
      notifyListeners();
    });
  }

  void resetQuiz() {
    currentIndex = 0;
    score = 0;
    isCompleted = false;
    selectedOption = null;
    _generateRandomQuestions();
    notifyListeners();
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
