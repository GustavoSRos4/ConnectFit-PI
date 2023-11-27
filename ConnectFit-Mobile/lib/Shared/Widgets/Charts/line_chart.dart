import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MyLineChart extends StatefulWidget {
  final List<List<dynamic>> dados;
  const MyLineChart({super.key, required this.dados});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  List<FlSpot> dadosGrafico = [];
  getDate(int index) {
    final micros = widget.dados[index][0].toDouble();
    final date = DateTime.fromMicrosecondsSinceEpoch(micros.round());
    return DateFormat('dd/MM - hh:mm').format(date);
  }

  List<FlSpot> teste(List<List<dynamic>> data) {
    List<FlSpot> dadosGrafico = [];
    for (int i = 0; i < data.length; i++) {
      dadosGrafico.add(
        FlSpot(
          i.toDouble(),
          data[i][1],
        ),
      );
    }
    return dadosGrafico;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9,
      child: LineChart(
        LineChartData(
          minY: 0,
          borderData: FlBorderData(
            show: false,
          ),
          titlesData: const FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          gridData: const FlGridData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              barWidth: 3,
              color: Colors.deepOrange,
              spots: teste(widget.dados),
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.deepOrange.withOpacity(0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.pretoPag,
              getTooltipItems: (data) {
                return data.map((item) {
                  final date = getDate(item.spotIndex);
                  return LineTooltipItem(
                    '${item.y}',
                    const TextStyle(
                        color: Colors.brancoBege,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: '\n $date',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.brancoBege.withOpacity(.5),
                          ))
                    ],
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
