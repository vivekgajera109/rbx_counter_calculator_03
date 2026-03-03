import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/meme_provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import '../presentation/widgets/cyber_background.dart';
import '../presentation/widgets/antigravity_card.dart';
import '../common/Ads/ads_card.dart';

class MemeScreen extends StatefulWidget {
  const MemeScreen({super.key});

  @override
  State<MemeScreen> createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen>
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
    return ChangeNotifierProvider(
      create: (_) => MemeProvider(),
      builder: (context, child) {
        return Consumer<MemeProvider>(
          builder: (context, provider, child) {
            final memes = provider.memes;
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
                  ).createShader(bounds),
                  child: const Text(
                    "GAMING MEMES",
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
                  child: SafeArea(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      itemCount: memes.length + (memes.length / 4).floor(),
                      itemBuilder: (context, index) {
                        // Logic to inject ads every 4 items
                        if (index > 0 && index % 5 == 4) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: NativeAdsScreen(),
                          );
                        }

                        // Adjust index for data list
                        final memeIndex = index - (index / 5).floor();
                        if (memeIndex >= memes.length) return const SizedBox();

                        final meme = memes[memeIndex];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AntigravityCard(
                            onTap: () {},
                            borderGradient: memeIndex % 2 == 0
                                ? [
                                    const Color(0xFF48CAE4),
                                    const Color(0xFF5E60CE)
                                  ]
                                : [
                                    const Color(0xFF9D4EDD),
                                    const Color(0xFF5E60CE)
                                  ],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Icon/Visual Element
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: (memeIndex % 2 == 0
                                              ? AppColors.secondary
                                              : AppColors.primary)
                                          .withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: (memeIndex % 2 == 0
                                                  ? AppColors.secondary
                                                  : AppColors.primary)
                                              .withOpacity(0.3)),
                                    ),
                                    child: Icon(
                                      memeIndex % 2 == 0
                                          ? Icons.emoji_emotions_outlined
                                          : Icons.videogame_asset_outlined,
                                      color: memeIndex % 2 == 0
                                          ? AppColors.secondary
                                          : AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  // Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          meme.title.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          meme.description,
                                          style: const TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // Share Action
                                  GestureDetector(
                                    onTap: () {
                                      final String content =
                                          "${meme.title}\n\n${meme.description}";
                                      Share.share(content, subject: meme.title);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.1)),
                                      ),
                                      child: const Icon(Icons.share_rounded,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
