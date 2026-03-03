import 'dart:ui';
import 'package:flutter/material.dart';

class AntigravityCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final List<Color> borderGradient;
  final double borderRadius;
  final bool hasGlow;

  const AntigravityCard({
    super.key,
    required this.child,
    required this.onTap,
    this.borderGradient = const [Color(0xFF9D4EDD), Color(0xFF48CAE4)],
    this.borderRadius = 22,
    this.hasGlow = true,
  });

  @override
  State<AntigravityCard> createState() => _AntigravityCardState();
}

class _AntigravityCardState extends State<AntigravityCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                if (widget.hasGlow && _isHovering)
                  BoxShadow(
                    color: widget.borderGradient.first.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Inner Gradient Border Glow
                      Positioned.fill(
                        child: CustomPaint(
                          painter: GradientBorderPainter(
                            gradient: LinearGradient(
                              colors: widget.borderGradient
                                  .map((e) => e.withOpacity(0.4))
                                  .toList(),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            radius: widget.borderRadius,
                            strokeWidth: 1.5,
                          ),
                        ),
                      ),
                      widget.child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double radius;
  final double strokeWidth;

  GradientBorderPainter({
    required this.gradient,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(GradientBorderPainter oldDelegate) =>
      oldDelegate.gradient != gradient || oldDelegate.radius != radius;
}
