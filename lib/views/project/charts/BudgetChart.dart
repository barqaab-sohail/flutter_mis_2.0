import 'dart:core';
import 'package:first_project/model/project/BudgetChartModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../controllers/project/ProjectListController.dart';
import '../../../model/project/BarChartModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BudgetChart extends StatefulWidget {
  const BudgetChart({super.key});

  @override
  State<BudgetChart> createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  final projectListController = Get.find<ProjectListController>();

  Map<String, double> dataMap = {};
  // {
  //   "Flutter": 5,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };

  Future<Map<String, double>> getChartData() async {
    BudgetChartModel data = await projectListController.getProejctChart(
        id: Get.arguments[0].toString());
    dataMap = {
      "Budget Utilization": double.parse(data.budgetUtilization!),
      "Remaining Budget": double.parse(data.remainingBudget!),
    };
    return dataMap;
  }

  List<charts.Series<BarChartModel, String>> series = [];

  Future<List<charts.Series<BarChartModel, String>>> getBarChartData() async {
    BudgetChartModel data = await projectListController.getProejctChart(
        id: Get.arguments[0].toString());

    List<BarChartModel> data1 = [
      BarChartModel(
          description: "Total Cost",
          value: data.totalCost!,
          color: charts.ColorUtil.fromDartColor(Colors.red)),
      BarChartModel(
          description: "Total Invoice",
          value: data.totalInvoice!,
          color: charts.ColorUtil.fromDartColor(Colors.blue)),
      BarChartModel(
          description: "Pending Invoice",
          value: data.pendingInvoices!,
          color: charts.ColorUtil.fromDartColor(Colors.green)),
    ];

    series = [
      charts.Series(
        id: "financial",
        data: data1,
        domainFn: (BarChartModel series, _) => series.description,
        measureFn: (BarChartModel series, _) => series.value,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[1] + ' - Budget Chart'),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: FutureBuilder(
                    future: getChartData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          dataMap["Budget Utilization"] != 0.0) {
                        return PieChart(
                          dataMap: dataMap,
                          centerText: 'Budget Utilization',
                          chartRadius: MediaQuery.of(context).size.width / 1.7,
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        );
                      } else if (dataMap["Budget Utilization"] == 0.0) {
                        return Center(child: Text("No Utilization Found"));
                      } else
                        return CircularProgressIndicator();
                    }),
              )),
              Expanded(
                  child: Center(
                child: FutureBuilder(
                    future: getBarChartData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: charts.BarChart(
                            series,
                            animate: true,
                          ),
                        );
                      } else
                        return CircularProgressIndicator();
                    }),
              )),
            ],
          ),
        ));
  }
}
