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
    this.color = Colors.brancoBege,
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

class CustomRowTextVariosItens extends StatelessWidget {
  final String indicador;
  final Color color;
  final double? fontSize;
  final String textos;

  const CustomRowTextVariosItens({
    Key? key,
    required this.indicador,
    this.color = Colors.brancoBege,
    this.fontSize,
    required this.textos,
  }) : super(key: key);

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
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomText(
                  color: color,
                  text: textos,
                  fontSize: 14,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomRowTextVariosItensPersonal extends StatelessWidget {
  final Color color;
  final double? fontSize;
  final String textos;

  const CustomRowTextVariosItensPersonal({
    Key? key,
    this.color = Colors.brancoBege,
    this.fontSize,
    required this.textos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CustomText(
            color: color,
            text: textos,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
