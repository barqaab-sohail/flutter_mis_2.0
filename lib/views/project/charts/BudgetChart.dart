import 'dart:core';
import 'package:first_project/model/project/BudgetChartModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../controllers/project/ProjectListController.dart';

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
      "Budget Utilization": data.budgetUtilization!,
      "Remaining Budget": data.remainingBudget!,
    };
    if (dataMap["Budget Utilization"] == 0) {
      print("No Utilization");
    }
    ;
    return dataMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[1] + ' - Budget Chart'),
        ),
        body: Container(
          child: Center(
            child: FutureBuilder(
                future: getChartData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PieChart(
                      dataMap: dataMap,
                      chartRadius: MediaQuery.of(context).size.width / 1.7,
                      legendOptions: LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions:
                          ChartValuesOptions(showChartValuesInPercentage: true),
                    );
                  } else
                    return CircularProgressIndicator();
                }),
          ),
        ));
  }
}
