import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/app_colors.dart';
import 'package:notes_app_xgen/core/utils/custom_log.dart';
import 'package:notes_app_xgen/widgets/custom_text.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.buttonColor,
      this.buttonHeight,
      this.buttonWidth,
      this.horizontalpadding,
      this.verticalPadding,
      this.borderRadius,
      this.buttonStyle,
      this.icon,
      this.borderColor,
      this.iconColor,
      this.onLoading,
      this.leadingImage,
      this.leadingImageHeight,
      this.customBorderRadius});

  final VoidCallback onTap;
  final String buttonText;
  final Color? buttonColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? horizontalpadding;
  final double? verticalPadding;
  final double? borderRadius;
  final TextStyle? buttonStyle;
  final IconData? icon;
  final Color? borderColor;
  final bool? onLoading;
  final Color? iconColor;
  final String? leadingImage;
  final double? leadingImageHeight;
  final BorderRadius? customBorderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (onLoading ?? false)
            ? () {
                customLog('button already called');
              }
            : onTap,
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 0,
              horizontal: horizontalpadding ?? 0),
          decoration: BoxDecoration(
              color: buttonColor,
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null,
              borderRadius: customBorderRadius ??
                  BorderRadius.circular(borderRadius ?? 0)),
          child: (onLoading ?? false)
              ? FittedBox(
                  child: Padding(
                  padding: EdgeInsets.all(15),
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.white,
                  ),
                ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(text: buttonText, textStyle: buttonStyle),
                  ],
                ),
        ));
  }
}
