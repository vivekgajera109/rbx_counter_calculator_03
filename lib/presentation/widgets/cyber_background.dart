import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CyberBackground extends StatefulWidget {
  final Widget child;
  const CyberBackground({super.key, required this.child});

  @override
  State<CyberBackground> createState() => _CyberBackgroundState();
}

class _CyberBackgroundState extends State<CyberBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Background
        Container(color: AppColors.background),

        // Animated Grid
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: CyberGridPainter(_controller.value),
              size: Size.infinite,
            );
          },
        ),

        // Glow Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                Colors.transparent,
                AppColors.primary.withOpacity(0.05),
                AppColors.secondary.withOpacity(0.05),
                AppColors.background.withOpacity(0.8),
              ],
            ),
          ),
        ),

        // The Content
        widget.child,
      ],
    );
  }
}

class CyberGridPainter extends CustomPainter {
  final double progress;
  CyberGridPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..strokeWidth = 1.0;

    final double step = 40.0;
    final double offset = progress * step;

    // Vertical Lines
    for (double x = -step; x < size.width + step; x += step) {
      canvas.drawLine(
        Offset(x + offset % step, 0),
        Offset(x + offset % step, size.height),
        paint,
      );
    }

    // Horizontal Lines
    for (double y = -step; y < size.height + step; y += step) {
      canvas.drawLine(
        Offset(0, y + offset % step),
        Offset(size.width, y + offset % step),
        paint,
      );
    }

    // Subtle Glow at intersections

    // Random dots or "data" particles could go here if needed
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
