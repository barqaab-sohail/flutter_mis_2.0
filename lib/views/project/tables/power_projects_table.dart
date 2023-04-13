import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProjectProjectsTable extends StatefulWidget {
  const ProjectProjectsTable({super.key});

  @override
  State<ProjectProjectsTable> createState() => _ProjectProjectsTableState();
}

class _ProjectProjectsTableState extends State<ProjectProjectsTable> {
  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          )
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "Id": index,
            "title": "Item $index",
            "Price": Random().nextInt(10000)
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['title'])),
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
