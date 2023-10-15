import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/Charts/line_chart.dart';
import 'package:projeto/Pages/Graphics/data.dart';

class GraphicsPage extends StatelessWidget {
  const GraphicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: CustomText(
          text: 'Gráficos',
          isBold: true,
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange,
                  style: BorderStyle.solid,
                  width: 10,
                ),
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const CustomText(text: 'Line Chart'),
                  const SizedBox(
                    height: 20,
                  ),
                  MyLineChart(points: chartData)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
