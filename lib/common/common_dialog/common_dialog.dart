// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonDialog {
  static void show(
    BuildContext context, {
    required bool success,
    required String title,
    required String message,
    required String buttonText,
    String? lottieAsset,
    VoidCallback? onButtonPressed,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = Curves.elasticOut.transform(anim1.value);
        return Transform.scale(
          scale: curve,
          child: Opacity(
            opacity: anim1.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Main Dialog Container
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0D0D),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: success
                            ? const Color(0xFF48CAE4).withOpacity(0.5)
                            : Colors.redAccent.withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (success
                                  ? const Color(0xFF48CAE4)
                                  : Colors.redAccent)
                              .withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title with ShaderMask
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: success
                                ? [
                                    const Color(0xFF48CAE4),
                                    const Color(0xFF9D4EDD)
                                  ]
                                : [Colors.redAccent, Colors.orangeAccent],
                          ).createShader(bounds),
                          child: Text(
                            title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Message text
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Action Button
                        GestureDetector(
                          onTap:
                              onButtonPressed ?? () => Navigator.pop(context),
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: success
                                    ? [
                                        const Color(0xFF48CAE4),
                                        const Color(0xFF9D4EDD)
                                      ]
                                    : [Colors.redAccent, Colors.red.shade900],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: (success
                                          ? const Color(0xFF48CAE4)
                                          : Colors.redAccent)
                                      .withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              buttonText.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Floating Icon/Lottie at Top
                  Positioned(
                    top: -50,
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: success
                              ? const Color(0xFF48CAE4)
                              : Colors.redAccent,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (success
                                    ? const Color(0xFF48CAE4)
                                    : Colors.redAccent)
                                .withOpacity(0.4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: lottieAsset != null
                            ? Lottie.asset(
                                lottieAsset,
                                fit: BoxFit.cover,
                                repeat: true,
                              )
                            : Icon(
                                success
                                    ? Icons.check_circle_rounded
                                    : Icons.error_rounded,
                                color: success
                                    ? const Color(0xFF48CAE4)
                                    : Colors.redAccent,
                                size: 60,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
