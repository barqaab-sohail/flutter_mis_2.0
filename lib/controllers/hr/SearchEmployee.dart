import 'package:flutter/material.dart';
import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:get/get.dart';

class SearchEmployee extends SearchDelegate {
  final employeeListController = Get.find<EmployeListController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return employeeListController.getEmployeeListWidget(query: query);
  }
}
