import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/quiz_provider.dart';
import 'package:rbx_counter/common/Ads/ads_card.dart';
import 'package:rbx_counter/common/common_button/common_button.dart';
import 'package:rbx_counter/constants/app_style.dart';
import 'package:rbx_counter/constants/static_decoration.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import '../common/common_app_bar/common_app_bar.dart';
import 'quiz_completed_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Quiz Time",
        showBackButton: true,
      ),
      bottomNavigationBar: NativeAdsScreen(),
      body: Consumer<QuizProvider>(
        builder: (context, provider, child) {
          // Navigate safely after frame is built
          if (provider.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const QuizCompletedScreen(),
              //   ),
              // );
              navigateWithAnimation(context, const QuizCompletedScreen());
            });
          }

          final currentQuestion = provider.questions[provider.currentIndex];

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                CommonOutlineButton(
                  radius: 0,
                  title:
                      "Question ${provider.currentIndex + 1}/${provider.questions.length}",
                  onTap: null,
                ),
                height20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Text(
                        currentQuestion.question,
                        style: AppTextStyle.semiBold20.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ...currentQuestion.options.map(
                        (option) {
                          Color borderColor = Colors.transparent;

                          if (provider.selectedOption != null) {
                            if (option == currentQuestion.correctAnswer) {
                              borderColor = Colors.green;
                            } else if (option == provider.selectedOption) {
                              borderColor = Colors.red;
                            }
                          }

                          return CommonOutlineButton(
                              title: option,
                              onTap: provider.selectedOption == null
                                  ? () {
                                      provider.answerQuestion(option);
                                    }
                                  : null,
                              borderColor: borderColor);
                        },
                      ),
                    ],
                  ),
                ),
                //    Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         side: BorderSide(color: borderColor, width: 3),
                //         backgroundColor: Colors.white,
                //         foregroundColor: Colors.black,
                //         padding: const EdgeInsets.symmetric(vertical: 12),
                //       ),
                //       onPressed: provider.selectedOption == null
                //           ? () {
                //               provider.answerQuestion(option);
                //             }
                //           : null,
                //       child: Text(option),
                //     ),
                //   );
                // }).toList(),
                // const SizedBox(height: 20),
                // Text(
                //   "Score: ${provider.score}",
                //   style: const TextStyle(
                //       fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
