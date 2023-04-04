import 'package:charts_flutter/flutter.dart' as charts;

class InoviceChartModel {
  String description;
  int value;
  final charts.Color color;

  InoviceChartModel({
    required this.description,
    required this.value,
    required this.color,
  });
}
