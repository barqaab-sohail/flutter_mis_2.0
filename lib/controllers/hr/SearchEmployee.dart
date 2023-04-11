import 'package:first_project/model/hr/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:get/get.dart';

import '../../views/hr/EmployeeDocumentsView.dart';

class SearchEmployee extends SearchDelegate {
  final employeeListController = Get.put(EmployeListController());

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
    return FutureBuilder<List<EmployeeModal>>(
      future: employeeListController.EmployeeList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                onTap: () {
                  Get.to(EmployeeDocuments(), arguments: [
                    snapshot.data![index].id!,
                    snapshot.data![index].fullName!,
                  ]);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(snapshot.data![index].picture!,
                      fit: BoxFit.cover),
                ),
                title: Text(snapshot.data![index].fullName!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data![index].designation!),
                    Text('Employee No: ' + snapshot.data![index].employeeNo!),
                    Text(
                        'Date of Birth: ' + snapshot.data![index].dateOfBirth!),
                    Text('Date of Joining: ' +
                        snapshot.data![index].dateOfJoining!),
                    Text('Mobile: ' + snapshot.data![index].mobile!),
                    Text('Current Status: ' + snapshot.data![index].status!),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
