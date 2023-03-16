import 'package:first_project/model/hr/EmployeeDocumentModel.dart';
import 'package:first_project/model/hr/EmployeeModal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/controllers/hr/documents/EmployeeDocumentController.dart';

class EmployeeDocuments extends StatefulWidget {
  const EmployeeDocuments({super.key});

  @override
  State<EmployeeDocuments> createState() => _EmployeeDocumentsState();
}

class _EmployeeDocumentsState extends State<EmployeeDocuments> {
  final employeeDocumentController = Get.put(EmployeeDocumentController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[1] + ' Documents'),
        ),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: FutureBuilder<List<EmployeeDocumentModel>>(
            future: employeeDocumentController.getEmployeeDocuments(
                id: Get.arguments[0].toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      title: Text(snapshot.data![index].description!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Extension Type: ' +
                              snapshot.data![index].extension!),
                          Text('File Szie : ' + snapshot.data![index].size!),
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
          ))
        ]));
  }
}
