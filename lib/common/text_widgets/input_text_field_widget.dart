// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_style.dart';
import '/constants/app_colors.dart';
import 'validator.dart';

Widget searchTextFormField(BuildContext context,
    {String? hintText,
    TextEditingController? controller,
    void Function(String?)? onChanged,
    void Function()? searchOnTap,
    void Function(String?)? onFieldSubmitted,
    FocusNode? focusNode}) {
  return textFormField(
    controller: controller,
    focusNode: focusNode,
    maxLines: 1,
    hintText: "${hintText ?? "Search"}...",
    border: const BorderSide(
      color: Colors.transparent,
    ),
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    suffixIcon: GestureDetector(
      onTap: searchOnTap,
      child: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(2),
        ),
        child: const Icon(
          Icons.search,
          color: AppColors.white,
        ),
      ),
    ),
    borderRaduis: 5,
  );
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    this.fieldKey,
    this.hintText,
    this.style,
    this.prefixIcon,
    required this.controller,
    this.borderColor,
    this.textInputAction,
    this.keyboardType,
    this.textStyle,
    this.filledColor,
    this.enabled,
    this.focusNode,
    this.validator,
  });
  final Key? fieldKey;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? textStyle;

  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final TextInputType? keyboardType;
  final Color? filledColor;
  final FormFieldValidator<String?>? validator;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return textFormField(
        fieldKey: fieldKey,
        hintText: hintText,

        // hintStyle: style ??
        //     AppTextStyle.semiBold15.copyWith(color: primaryButtonColor),
        // prefixIcon: UiInterface.prefixTextFieldIcon(AppAsset.icEnvelop),
        enabled: enabled,
        focusNode: focusNode,
        controller: controller,
        // textStyle: textStyle ??
        //     AppTextStyle.semiBold15.copyWith(color: primaryButtonColor),
        textInputAction: textInputAction,
        keyboardType: TextInputType.emailAddress,
        borderColor: borderColor,
        filledColor: filledColor,
        validator: validator ??
            (value) => Validators.validateEmail(
                  value!.trim(),
                ));
  }
}

class PasswordWidget extends StatefulWidget {
  final Key? fieldKey;
  final int? maxLength;
  final String? hintText;

  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const PasswordWidget({
    super.key,
    required this.controller,
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.validator,
    this.focusNode,
    this.textInputAction,
  });

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return textFormField(
        fieldKey: widget.fieldKey,
        hintText: widget.hintText,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        maxLines: 1,
        // prefixIcon: UiInterface.prefixTextFieldIcon(AppAsset.icLock),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.white,
          ),
        ),
        validator: widget.validator ??
            (value) => Validators.validateRequired(value!.trim(), 'Password')
        // (value) => Validators.validatePassword(value!.trim()),
        );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    this.fieldKey,
    this.hintText,
    this.validator,
    this.prefixIcon,
    required this.controller,
    this.maxLength,
    this.focusNode,
    this.autofocus,
    this.style,
    this.textInputAction,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.textStyle,
    this.keyboardType,
    this.borderColor,
    this.fillColor,
    this.enabled,
  });

  final Key? fieldKey;
  final String? hintText;
  final List<TextInputFormatter?>? inputFormatters;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? style;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      fieldKey: fieldKey,
      hintText: hintText,
      focusNode: focusNode,
      enabled: enabled,
      borderRaduis: 10,
      hintStyle: style ??
          AppTextStyle.normalRegular12.copyWith(
            color: AppColors.primary,
          ),
      textStyle: textStyle ?? AppTextStyle.normalRegular12,
      controller: controller,
      style: style,
      prefixIcon: prefixIcon,
      filledColor: fillColor,
      validator: validator,
      textAlign: textAlign,
      maxLength: maxLength,
      borderColor: borderColor,
      textInputAction: textInputAction,
      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]'))],
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.fieldKey,
      this.hintText,
      this.textStyle,
      this.hintStyle,
      this.validator,
      this.prefixIcon,
      required this.controller,
      this.focusNode,
      this.maxLines,
      this.maxLength,
      this.suffixIcon,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted,
      this.textInputAction,
      this.keyboardType,
      this.borderColor,
      this.filledColor,
      this.enabled,
      this.readonly,
      this.textAlign = TextAlign.left,
      this.contentPadding,
      this.border});

  final Key? fieldKey;
  final bool? readonly;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final Color? filledColor;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final bool? enabled;
  final EdgeInsetsGeometry? contentPadding;
  final BorderSide? border;
  @override
  Widget build(BuildContext context) {
    return textFormField(
        fieldKey: fieldKey,
        focusNode: focusNode,
        hintText: hintText,
        controller: controller,
        borderRaduis: 10,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        maxLength: maxLength,
        maxLines: maxLines,
        enabled: enabled ?? true,
        textInputAction: textInputAction,
        textAlign: textAlign,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(20, 15, 10, 15),
        textStyle: textStyle,
        hintStyle: hintStyle ??
            AppTextStyle.normalRegular12.copyWith(
              color: AppColors.primary,
            ),
        borderColor: borderColor,
        filledColor: filledColor,
        border: border);
  }
}

class OutlineTextFormFieldWidget extends StatelessWidget {
  const OutlineTextFormFieldWidget({
    super.key,
    this.fieldKey,
    this.hintText,
    this.enabled,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.prefixIcon,
    required this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.textAlign = TextAlign.left,
  });

  final Key? fieldKey;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      fieldKey: fieldKey,
      focusNode: focusNode,
      enabled: enabled,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.text,
      validator: validator,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLength: maxLength,
      maxLines: maxLines,
      textInputAction: textInputAction,
      textAlign: textAlign,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      textStyle: textStyle,
      hintStyle: hintStyle,
    );
  }
}

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({
    super.key,
    this.fieldKey,
    this.hintText,
    this.validator,
    required this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.filledColor,
    this.hintStyle,
    this.enabled,
  });

  final Key? fieldKey;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? filledColor;
  final FormFieldValidator<String?>? validator;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return textFormField(
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        enabled: enabled,
        fieldKey: fieldKey,
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        hintText: hintText,
        hintStyle: AppTextStyle.semiBold15,
        textStyle: AppTextStyle.semiBold15,
        filledColor: AppColors.black,
        borderColor: Colors.transparent);
  }
}

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  final String? hintText;
  final Function(String?)? onFieldSubmit;
  final Function(String?)? onFieldChange;
  final Function()? onSubmit;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  TextEditingController? controller;

  SearchBar({
    super.key,
    this.hintText,
    this.onFieldSubmit,
    this.onSubmit,
    this.onFieldChange,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      onFieldSubmitted: onFieldSubmit,
      hintText: hintText ?? "Find restaurant or coffeeshop",
      hintStyle: AppTextStyle.bold15,

      prefixIcon: prefixIcon ??
          IconButton(
            icon: const Icon(
              CupertinoIcons.search,
              color: AppColors.white,
            ),
            splashRadius: 5,
            onPressed: onSubmit,
          ),
      onChanged: onFieldChange,
      borderColor: Colors.transparent,
      filledColor: AppColors.black,

      // suffixIcon: IconButton(
      //   icon: Icon(
      //     suffixIcon ?? Icons.arrow_forward,
      //     color: hintGrey,
      //   ),
      //   onPressed: onSubmit,
      // ),
    );
  }
}

Widget textFormField({
  final Key? fieldKey,
  final String? hintText,
  final String? labelText,
  final String? helperText,
  final String? initialValue,
  final int? errorMaxLines,
  final int? maxLines,
  final int? maxLength,
  final double? borderRaduis = 3,
  final bool? enabled,
  final bool autofocus = false,
  final bool obscureText = false,
  final Color? filledColor,
  final Color? cursorColor,
  final Color? borderColor,
  final Widget? prefixIcon,
  final Widget? suffixIcon,
  final Widget? suffix,
  final FocusNode? focusNode,
  final TextStyle? style,
  final TextStyle? textStyle,
  final TextStyle? hintStyle,
  final TextAlign textAlign = TextAlign.left,
  final TextEditingController? controller,
  final List<TextInputFormatter>? inputFormatters,
  final TextInputAction? textInputAction,
  final TextInputType? keyboardType,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  final GestureTapCallback? onTap,
  final FormFieldSetter<String?>? onSaved,
  final FormFieldValidator<String?>? validator,
  final ValueChanged<String?>? onChanged,
  final ValueChanged<String?>? onFieldSubmitted,
  final BorderSide? border,
  final Color? errorColor,
  final EdgeInsetsGeometry? contentPadding,
  final bool? readonly,
  final String? counterText,
}) {
  return TextFormField(
    key: fieldKey,
    readOnly: readonly ?? false,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText,
    enabled: enabled,
    validator: validator,
    maxLength: maxLength,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    onTap: onTap,
    onSaved: onSaved,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    autocorrect: true,
    autofocus: autofocus,
    textAlign: textAlign,
    cursorColor: AppColors.white,
    cursorHeight: 20,
    style: textStyle ??
        AppTextStyle.normalRegular15
            .copyWith(color: AppColors.primary, fontSize: 17),
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
      counterText: counterText == null ? null : "",
      counterStyle: AppTextStyle.normalRegular15
          .copyWith(color: AppColors.primary, fontSize: 10),
      errorStyle: AppTextStyle.normalRegular15
          .copyWith(color: errorColor ?? Colors.red, fontSize: 14),
      prefixIcon: prefixIcon,
      // isDense: true,
      contentPadding: contentPadding ?? EdgeInsets.fromLTRB(15, 0, 10, 0),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis ?? 3),
        borderSide: border ?? BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis ?? 3),
        borderSide: border ?? BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis ?? 3),
        borderSide: border ?? BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis ?? 3),
        borderSide: border ?? BorderSide.none,
      ),
      errorMaxLines: 5,
      fillColor: filledColor ?? AppColors.white,
      filled: true,
      hintStyle: hintStyle ??
          AppTextStyle.normalRegular15.copyWith(
              color: AppColors.primary.withOpacity(0.6), fontSize: 17),
      hintText: hintText,
      enabled: enabled ?? true,
      suffixIcon: suffixIcon,
      suffix: suffix,
      labelText: labelText,
      helperText: helperText,
    ),
  );
}

TextFormField outlineTextField({
  final Key? fieldKey,
  final String? hintText,
  final String? labelText,
  final String? helperText,
  final String? initialValue,
  final int? errorMaxLines,
  final int? maxLines,
  final int? maxLength,
  final bool? enabled,
  final bool autofocus = false,
  final bool obscureText = false,
  final Color? filledColor,
  final Color? cursorColor,
  final Widget? prefixIcon,
  final Widget? suffixIcon,
  final FocusNode? focusNode,
  final TextStyle? style,
  final TextStyle? textStyle,
  final TextStyle? hintStyle,
  final TextAlign textAlign = TextAlign.left,
  final TextEditingController? controller,
  final List<TextInputFormatter>? inputFormatters,
  final TextInputAction? textInputAction,
  final TextInputType? keyboardType,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  final GestureTapCallback? onTap,
  final FormFieldSetter<String?>? onSaved,
  final FormFieldValidator<String?>? validator,
  final ValueChanged<String?>? onChanged,
  final ValueChanged<String?>? onFieldSubmitted,
}) {
  return TextFormField(
    key: fieldKey,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText,
    enabled: enabled,
    validator: validator,
    maxLength: maxLength,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    onTap: onTap,
    onSaved: onSaved,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    autocorrect: true,
    autofocus: autofocus,
    textAlign: textAlign,
    cursorColor: AppColors.primary,
    cursorHeight: 20,
    style: textStyle ?? AppTextStyle.normalRegular12,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      border: outlineBorderDecoration,
      enabledBorder: outlineBorderDecoration,
      focusedBorder: outlineBorderDecoration,
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.zero,
      ),
      hintText: hintText,
      hintStyle: hintStyle ?? AppTextStyle.normalRegular12,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: labelText,
      helperText: helperText,
    ),
  );
}

OutlineInputBorder outlineBorderDecoration = const OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.primary, width: 1.2),
  borderRadius: BorderRadius.zero,
);
