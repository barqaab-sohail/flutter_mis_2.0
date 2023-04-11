import 'package:first_project/controllers/project/ProjectListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/project/ProjectListModel.dart';
import '../../../views/project/ProjectDocumentsView.dart';
import '../../../views/project/charts/BudgetChart.dart';

class SearchProject extends SearchDelegate {
  final projectListController = Get.put(ProjectListController());

  @override
  void initState() {}

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
    return FutureBuilder<List<ProjectListModal>>(
      future: projectListController.ProjectList(query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(children: [
                    Card(
                      color: Colors.blue[200],
                      shadowColor: Colors.amber,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        // leading: CircleAvatar(child: Icon(Icons.add)),
                        title: Text(
                          snapshot.data![index].projectName!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project Type: ' +
                                    snapshot.data![index].projectType!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Total Cost Without GST: ' +
                                    snapshot.data![index]
                                        .totalProjectCostWihtoutGST!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Total Payment Received: ' +
                                    snapshot.data![index].paymentReceived!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Total Pending Payments: ' +
                                    snapshot.data![index].pendingPayments!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Budget Utilization Upto: ' +
                                    snapshot.data![index].latestInvoiceMonth! +
                                    ' - ' +
                                    snapshot.data![index].budgetUtilization!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Physical Progress Upto: ' +
                                    snapshot.data![index].projectProgress!,
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.to(BudgetChart(), arguments: [
                                          snapshot.data![index].id!,
                                          snapshot.data![index].projectName!,
                                        ]);
                                      },
                                      child: Text('Project Charts')),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.to(ProjectDocument(), arguments: [
                                          snapshot.data![index].id!,
                                          snapshot.data![index].projectName!,
                                        ]);
                                      },
                                      child: Text('Project Documents'))
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]),
                        // trailing: Icon(Icons.train),
                      ),
                    ),
                  ]),
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
