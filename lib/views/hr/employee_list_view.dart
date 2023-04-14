import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:first_project/controllers/hr/SearchEmployee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../drawer/DrawerView.dart';
import 'package:first_project/views/drawer/drawer_view_class.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  // Timer? timer;
  DrawerViewClass drawerViewClass = DrawerViewClass();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  final employeeListController = Get.put(EmployeListController());

  @override
  Widget build(BuildContext context) {
    // timer = Timer.periodic(Duration(seconds: 50),
    //     (Timer t) => employeeListController.getNewEmployeeList());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Employee List'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchEmployee());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        drawer: Drawer(child: drawerViewClass.buildDrawer()),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(child: employeeListController.getEmployeeListWidget())
        ]));
  }
}
