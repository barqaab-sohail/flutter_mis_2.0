import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String description;
  int value;
  final charts.Color color;

  BarChartModel({
    required this.description,
    required this.value,
    required this.color,
  });
}
