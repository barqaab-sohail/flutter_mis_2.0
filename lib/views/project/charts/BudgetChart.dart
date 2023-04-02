import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class BudgetChart extends StatefulWidget {
  const BudgetChart({super.key});

  @override
  State<BudgetChart> createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  Map<String, double> dataMap = {};
  Future<Map<String, double>> pieChart() async {
    await Future.delayed(Duration(seconds: 2));
    dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };
    return dataMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Budget Chart'),
        ),
        body: Container(
          child: Center(
            child: FutureBuilder(
                future: pieChart(),
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
