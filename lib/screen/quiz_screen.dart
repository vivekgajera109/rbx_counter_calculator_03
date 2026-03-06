import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/quiz_provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/navigation_helper/navigation_helper.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';
import '../common/Ads/ads_card.dart';
import 'quiz_completed_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () async {
            await checkAdsAndOpenUrl(context);
            if (context.mounted) Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
          ).createShader(bounds),
          child: const Text(
            "QUIZ TIME",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: CyberBackground(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<QuizProvider>(
            builder: (context, provider, child) {
              if (provider.isCompleted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  navigateWithAnimation(context, const QuizCompletedScreen());
                });
              }

              final currentQuestion = provider.questions[provider.currentIndex];

              return SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // Progress Bar
                      _buildProgressBar(provider),
                      const SizedBox(height: 30),

                      // Question Card
                      AntigravityCard(
                        onTap: () {},
                        borderGradient: const [
                          Color(0xFF48CAE4),
                          Color(0xFF9D4EDD)
                        ],
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              const Text(
                                "QUESTION",
                                style: TextStyle(
                                  color: Color(0xFF48CAE4),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentQuestion.question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Options
                      ...currentQuestion.options.map((option) {
                        bool isSelected = provider.selectedOption == option;
                        bool isCorrect =
                            option == currentQuestion.correctAnswer;

                        Color borderPrimary = const Color(0xFF5E60CE);
                        Color borderSecondary = const Color(0xFF48CAE4);

                        if (provider.selectedOption != null) {
                          if (isCorrect) {
                            borderPrimary = Colors.greenAccent;
                            borderSecondary = Colors.green;
                          } else if (isSelected) {
                            borderPrimary = Colors.redAccent;
                            borderSecondary = Colors.red;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AnimatedScale(
                            scale: isSelected ? 0.98 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            child: AntigravityCard(
                              onTap: provider.selectedOption == null
                                  ? () => provider.answerQuestion(option)
                                  : () {},
                              borderGradient: [borderPrimary, borderSecondary],
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.w900
                                        : FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 20),
                      const NativeAdsScreen(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(QuizProvider provider) {
    double progress = (provider.currentIndex + 1) / provider.questions.length;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PROGRESS",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            Text(
              "${provider.currentIndex + 1}/${provider.questions.length}",
              style: const TextStyle(
                color: Color(0xFF48CAE4),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                width: MediaQuery.of(context).size.width * progress,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
                  ),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF48CAE4).withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
