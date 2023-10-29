import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projeto/Pages/Graphics/data.dart';

class MyLineChart extends StatelessWidget {
  final List<ChartData> points;
  const MyLineChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              barWidth: 5,
              color: Colors.deepOrange,
              spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
