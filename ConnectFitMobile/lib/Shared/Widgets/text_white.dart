import 'package:flutter/material.dart';

class TextWhite extends StatelessWidget {
  final String text;
  final double? fontSize;
  const TextWhite({
    super.key,
    required this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }
}
