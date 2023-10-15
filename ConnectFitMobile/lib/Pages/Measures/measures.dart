import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class MeasuresPage extends StatelessWidget {
  const MeasuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: CustomText(
          text: "Medidas",
          isBold: true,
        ),
        actions: [],
      ),
      body: Center(
          child: Icon(
        Icons.fact_check,
        size: 150,
      )),
    );
  }
}
