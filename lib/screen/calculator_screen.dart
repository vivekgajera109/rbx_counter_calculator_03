import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/calculator_provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';
import '../common/Ads/ads_card.dart';

class CalculatorScreen extends StatefulWidget {
  final CalculatorModel model;

  const CalculatorScreen({super.key, required this.model});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  double? result;
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CalculatorProvider>();

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
          onPressed: () => Navigator.pop(context),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
          ).createShader(bounds),
          child: Text(
            widget.model.title.toUpperCase(),
            style: const TextStyle(
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
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  // Input Card
                  AntigravityCard(
                    onTap: () {},
                    borderGradient: const [
                      Color(0xFF48CAE4),
                      Color(0xFF5E60CE)
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color:
                                          AppColors.secondary.withOpacity(0.3)),
                                ),
                                child: const Icon(Icons.flash_on_rounded,
                                    color: AppColors.secondary, size: 24),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "ENTER ${widget.model.from}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.1)),
                            ),
                            child: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900),
                              decoration: InputDecoration(
                                hintText: "0.00",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.1)),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(20),
                                suffixIcon: controller.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.white54),
                                        onPressed: () =>
                                            setState(() => controller.clear()),
                                      )
                                    : null,
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildPremiumButton(
                            onTap: () {
                              final value =
                                  double.tryParse(controller.text) ?? 0.0;
                              setState(() {
                                result = provider.convert(value, widget.model);
                              });
                              FocusScope.of(context).unfocus();
                            },
                            title: 'CALCULATE NOW',
                            gradient: const [
                              Color(0xFF48CAE4),
                              Color(0xFF5E60CE)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Result Section (Only shows if result exists)
                  if (result != null)
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                              opacity: value.clamp(0.0, 1.0), child: child),
                        );
                      },
                      child: AntigravityCard(
                        onTap: () {},
                        borderGradient: const [
                          Color(0xFFFF5400),
                          Color(0xFFFF0000)
                        ],
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              const Text(
                                "CONVERSION RESULT",
                                style: TextStyle(
                                  color: Color(0xFFFF5400),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "${result?.toStringAsFixed(2)} ${widget.model.to}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    Shadow(
                                        color: Color(0xFFFF5400),
                                        blurRadius: 25),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              _buildPremiumButton(
                                onTap: () async {
                                  await checkAdsAndOpenUrl(context);
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    setState(() {
                                      result = null;
                                      controller.clear();
                                      Navigator.pop(context);
                                    });
                                  });
                                },
                                title: 'DONE',
                                gradient: const [
                                  Color(0xFFFF5400),
                                  Color(0xFFFF0000)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),
                  const NativeAdsScreen(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumButton(
      {required VoidCallback onTap,
      required String title,
      required List<Color> gradient}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
