import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class GraphicsPage extends StatelessWidget {
  const GraphicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: CustomText(
          text: 'Gráficos',
          isBold: true,
        ),
        actions: [],
      ),
      body: Center(
        child: Icon(
          Icons.graphic_eq_sharp,
          size: 150,
        ),
      ),
    );
  }
}
