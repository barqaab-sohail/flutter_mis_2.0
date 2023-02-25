import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:first_project/modal/hr/EmployeeModal.dart';
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
        body: FutureBuilder<List<EmployeeModal>>(
          future: employeeListController.EmployeeList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Image.network(
                            snapshot.data![index].picture!,
                            width: 60,
                          ),
                          Text(snapshot.data![index].fullName!),
                          Text(snapshot.data![index].designation!),
                          Text('Employee No: ' +
                              snapshot.data![index].employeeNo!),
                          Text('Date of Birth: ' +
                              snapshot.data![index].dateOfBirth!),
                          Text('Date of Joining: ' +
                              snapshot.data![index].dateOfJoining!),
                          Text('Mobile: ' + snapshot.data![index].mobile!),
                          Text('Current Status: ' +
                              snapshot.data![index].status!),
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }
}
