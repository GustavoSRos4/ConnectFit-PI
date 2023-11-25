import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class CustomRowText extends StatelessWidget {
  final String indicador;
  final String valor;
  final Color color;
  final double? fontSize;

  const CustomRowText({
    super.key,
    required this.indicador,
    required this.valor,
    this.color = Colors.white,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: '$indicador:',
          isBold: true,
          fontSize: fontSize,
          color: color,
        ),
        const SizedBox(
          width: 7,
        ),
        CustomText(
          text: valor,
          color: color,
          fontSize: fontSize,
        ),
      ],
    );
  }
}
