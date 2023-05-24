import 'dart:core';

import 'package:first_project/model/project/BudgetChartModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../controllers/project/ProjectListController.dart';
import '../../../model/project/BarChartModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../../../model/project/ProjectLedgerActivityModel.dart';

class BudgetChart extends StatefulWidget {
  const BudgetChart({super.key});

  @override
  State<BudgetChart> createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  late int showingTooltip;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  final projectListController = Get.find<ProjectListController>();

  Map<String, double> dataMap = {};

  Future<Map<String, double>> getChartData() async {
    BudgetChartModel data = await projectListController.getProejctChart(
        id: Get.arguments[0].toString());
    dataMap = {
      "Budget Used": double.parse(data.budgetUtilization!),
      "Remaining Budget": double.parse(data.remainingBudget!),
    };
    return dataMap;
  }

  List<charts.Series<BarChartModel, String>> series = [];

  Future<List<charts.Series<BarChartModel, String>>>
      getProjectLedgerActivty() async {
    ProjectLedgerActivityModel data = await projectListController
        .getProjectLedgerActivty(id: Get.arguments[0].toString());

    List<BarChartModel> data1 = [
      BarChartModel(
          description: "Total Cost",
          value: data.projectCost!,
          color: charts.ColorUtil.fromDartColor(Colors.blueGrey)),
      BarChartModel(
          description: "Invoices",
          value: data.totalDebit!,
          color: charts.ColorUtil.fromDartColor(Colors.red)),
      BarChartModel(
          description: "Receipts",
          value: data.totalCredit!,
          color: charts.ColorUtil.fromDartColor(Colors.blue)),
      BarChartModel(
          description: "Pending Invoice",
          value: data.balance!,
          color: charts.ColorUtil.fromDartColor(Colors.green)),
    ];
    final value = new NumberFormat("#,##0", "en_US");
    series = [
      charts.Series(
          id: "financial",
          data: data1,
          domainFn: (BarChartModel series, _) => series.description,
          measureFn: (BarChartModel series, _) => series.value,
          colorFn: (BarChartModel series, _) => series.color,
          //value on bars
          labelAccessorFn: (BarChartModel series, _) =>
              '${series.description}: \PKR ${value.format(series.value)}'),
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
              SizedBox(height: 20),
              Text(
                "Budget Utilization Chart",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Center(
                child: FutureBuilder(
                    future: getChartData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          dataMap["Budget Utilization"] != 0.0) {
                        return PieChart(
                          dataMap: dataMap,
                          centerText: 'Budget Utilization Chart',
                          chartRadius: MediaQuery.of(context).size.width / 1.7,
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.bottom,
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
              Divider(color: Colors.black),
              SizedBox(height: 20),
              //Bar Chart
              Text(
                "Invoices Status  Chart",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Center(
                child: FutureBuilder(
                    future: getProjectLedgerActivty(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: charts.BarChart(
                            series,
                            animate: true,
                            barRendererDecorator: charts.BarLabelDecorator(
                              labelAnchor: charts.BarLabelAnchor.end,
                              labelPosition: charts.BarLabelPosition.outside,
                              outsideLabelStyleSpec: charts.TextStyleSpec(
                                  fontSize: 12,
                                  color: charts.ColorUtil.fromDartColor(
                                      Colors.red)),
                            ),
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
