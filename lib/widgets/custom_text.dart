import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.textStyle,
      this.maxLines,
      this.textOverflow,
      this.textAlign,
      this.fontStyle,
      this.textDecoration});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
        style: textStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: textDecoration,
                fontStyle: fontStyle ??
                    Theme.of(context).textTheme.bodyMedium?.fontStyle,
                color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: fontSize ??
                    Theme.of(context).textTheme.bodyMedium?.fontSize,
                fontWeight: fontWeight ??
                    Theme.of(context).textTheme.bodyMedium?.fontWeight));
  }
}
