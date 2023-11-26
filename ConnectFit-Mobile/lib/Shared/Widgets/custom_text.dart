import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool isBold;
  final Color color;
  final TextDecoration decoration;
  final int? maxLines;
  final TextAlign? textAlign;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.isBold = false,
    this.color = Colors.brancoBege,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.textAlign = TextAlign.justify,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        decoration: decoration,
        color: color,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
