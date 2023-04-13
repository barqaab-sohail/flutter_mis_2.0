import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PowerProjectsTable extends StatefulWidget {
  const PowerProjectsTable({super.key});

  @override
  State<PowerProjectsTable> createState() => _PowerProjectsTableState();
}

class _PowerProjectsTableState extends State<PowerProjectsTable> {
  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Power Projects List'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('Project Name')),
                  DataColumn(label: Text('Budget Utilized')),
                  DataColumn(label: Text('Physical Progress'))
                ],
                source: _data,
                header: const Center(
                  child: Text('Power Projects'),
                ),
                columnSpacing: 20,
                rowsPerPage: 10,
              )
            ],
          ),
        ));
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000)
          });

  @override
  DataRow? getRow(int index) {
    Color color;
    if (index % 2 == 0) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(
        _data[index]['title'],
        style: TextStyle(color: color),
      )),
      DataCell(Text(_data[index]['price'].toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
