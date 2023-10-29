import 'package:collection/collection.dart';

class ChartData {
  final double x;
  final double y;
  ChartData({required this.x, required this.y});
}

List<ChartData> get chartData {
  final data = <double>[
    65,
    68,
    60,
    73,
    80,
    75,
    68,
    78,
    65,
    68,
    60,
    73,
    80,
    75,
    68,
    78,
    65,
    68,
    60,
    73,
    80,
    75,
    68,
    78,
    65,
    68,
    60,
    73,
    80,
    75,
    68,
  ];
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}
