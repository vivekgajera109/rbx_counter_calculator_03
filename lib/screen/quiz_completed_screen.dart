import 'package:flutter/material.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import 'package:rbx_counter/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../Provider/quiz_provider.dart';
import '../common/common_app_bar/common_app_bar.dart';

class QuizCompletedScreen extends StatefulWidget {
  const QuizCompletedScreen({super.key});

  @override
  State<QuizCompletedScreen> createState() => _QuizCompletedScreenState();
}

class _QuizCompletedScreenState extends State<QuizCompletedScreen> {
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
    final provider = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      appBar: CommonAppBar(title: "Congratulations!"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "🎉 You scored ${provider.score}/${provider.questions.length}!",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Reward Earned: ${provider.score * 10} RBX",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                provider.resetQuiz();
                pushAndRemoveUntilWithAnimation(context, const HomeScreen());
              },
              child: const Text("Back to Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
