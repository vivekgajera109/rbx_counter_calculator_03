// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_style.dart';
import '../../constants/static_decoration.dart';
import '/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final bool boxShadow;

  const CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 10,
    this.style,
    this.margin,
    this.boxShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    final baseColor = backgroundColor ?? AppColors.white;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          color: isDisabled ? baseColor.withOpacity(0.5) : baseColor,
          border: Border.all(
            color: isDisabled
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.primary,
            width: 1.2,
          ),
          boxShadow: boxShadow && !isDisabled
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.4),
                    spreadRadius: -2,
                    blurRadius: 8,
                    offset: const Offset(1, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            title,
            style: style?.copyWith(
                  fontFamily: "Inter",
                  color: isDisabled
                      ? (textColor ?? AppColors.primary.withOpacity(0.5))
                      : textColor ?? AppColors.primary,
                ) ??
                AppTextStyle.bold20.copyWith(
                  fontFamily: "Inter",
                  color: isDisabled
                      ? (textColor ?? AppColors.primary.withOpacity(0.5))
                      : textColor ?? AppColors.primary,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor ?? AppColors.primary),
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
        child: child ??
            Text(
              title,
              style: style?.copyWith(
                    fontFamily: "Inter",
                    color: textColor ?? AppColors.white,
                  ) ??
                  AppTextStyle.semiBold15.copyWith(
                    fontFamily: "Inter",
                    color: textColor ?? AppColors.white,
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
        height: height ?? (kIsWeb ? 50 : 40),
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          border: Border.all(color: borderColor ?? AppColors.primary),
          borderRadius: BorderRadius.circular(5),
          boxShadow: boxShadow
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(1, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor ?? AppColors.primary,
            ),
            width05,
            Text(
              title,
              style: style?.copyWith(
                    fontFamily: "Inter",
                    color: textColor ?? AppColors.primary,
                  ) ??
                  AppTextStyle.normalRegular15.copyWith(
                    fontFamily: "Inter",
                    color: textColor ?? AppColors.primary,
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.location_on_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
}
