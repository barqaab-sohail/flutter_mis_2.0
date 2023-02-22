import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../drawer/Drawer.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final employeeListController = Get.put(EmployeListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Employee List'),
        ),
        drawer: HomeDrawer(),
        body: Column(
          children: [],
        ));
    ;
  }
}
