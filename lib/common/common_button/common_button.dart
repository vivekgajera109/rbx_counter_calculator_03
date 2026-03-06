// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final bool boxShadow;
  final double? height;

  const CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 32,
    this.style,
    this.margin,
    this.boxShadow = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 60,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          gradient: isDisabled
              ? LinearGradient(colors: [
                  Colors.grey.withOpacity(0.3),
                  Colors.grey.withOpacity(0.1)
                ])
              : const LinearGradient(
                  colors: [Color(0xFF48CAE4), Color(0xFF9D4EDD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: boxShadow && !isDisabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF48CAE4).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: style?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ) ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
          ),
        ),
      ),
    );
  }
}

class CommonOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? style;
  final double? width;
  final double? height;
  final bool boxShadow;
  final bool isBorder;
  final double? radius;
  final Widget? child;
  const CommonOutlineButton({
    super.key,
    required this.title,
    this.onTap,
    this.textColor,
    this.borderColor,
    this.style,
    this.width,
    this.height,
    this.boxShadow = false,
    this.isBorder = true,
    this.child,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 55,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(
            color: borderColor ?? const Color(0xFF48CAE4).withOpacity(0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
        child: child ??
            Text(
              title.toUpperCase(),
              style: style?.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ) ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}

class CommonOutlineIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? style;
  final double? width;
  final double? height;
  final bool boxShadow;

  const CommonOutlineIconButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
    this.textColor,
    this.borderColor,
    this.style,
    this.width,
    this.height,
    this.boxShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 45,
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(
            color: borderColor ?? const Color(0xFF48CAE4).withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: style?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ) ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LocationButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 37,
        width: 37,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.location_on_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
