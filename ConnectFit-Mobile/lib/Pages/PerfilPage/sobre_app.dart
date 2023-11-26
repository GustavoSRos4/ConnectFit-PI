import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class PerfilSobreApp extends StatelessWidget {
  const PerfilSobreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        actions: [],
        title: Text('Sobre o Aplicativo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomText(
              textAlign: TextAlign.left,
              fontSize: 15,
              text:
                  "App desenvolvido por estudantes do 4º período de Sistemas de Informação - UNIPAM.\n\nUma criação dedicada para o Projeto Integrador.\n\nCombinando esforços e conhecimentos para oferecer uma solução única e inovadora.",
            ),
            CustomTextLiquid(
              text: "Gustavo",
            ),
            CustomTextLiquid(
              text: "Henrique",
            ),
            CustomTextLiquid(
              text: "João Vitor",
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextLiquid extends StatelessWidget {
  final String text;
  final Color waveColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double boxHeight;
  const CustomTextLiquid({
    super.key,
    required this.text,
    this.waveColor = Colors.deepOrange,
    this.fontSize = 30,
    this.fontWeight = FontWeight.bold,
    this.boxHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pretoPag,
      child: TextLiquidFill(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        text: text,
        waveColor: waveColor,
        boxBackgroundColor: Colors.pretoPag,
        boxHeight: boxHeight,
      ),
    );
  }
}
