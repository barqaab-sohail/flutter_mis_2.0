import 'package:first_project/controllers/project/ProjectListController.dart';
import 'package:first_project/model/project/ProjectListModel.dart';
import 'package:first_project/views/project/charts/BudgetChart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/project/search/searchProject.dart';
import 'package:first_project/views/project/ProjectDocumentsView.dart';

import '../drawer/drawer_view_class.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  DrawerViewClass drawerViewClass = DrawerViewClass();
  final projectListController = Get.put(ProjectListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Project List'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchProject());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        drawer: Drawer(child: drawerViewClass.buildDrawer()),
        body: FutureBuilder<List<ProjectListModal>>(
          future: projectListController.ProjectList(),
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
                            title: SelectableText(
                              snapshot.data![index].projectName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    'Commencement Date: ' +
                                        snapshot.data![index].commencementDate!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
                                    'Completion Date: ' +
                                        snapshot.data![index].completionDate!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
                                    'Project Type: ' +
                                        snapshot.data![index].projectType!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
                                    'Total Cost Without GST: ' +
                                        snapshot.data![index]
                                            .totalProjectCostWihtoutGST!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
                                    'Total Payment Received: ' +
                                        snapshot.data![index].paymentReceived!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
                                    'Total Pending Payments: ' +
                                        snapshot.data![index].pendingPayments!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
                                    'Budget Utilization Upto: ' +
                                        snapshot
                                            .data![index].latestInvoiceMonth! +
                                        ' - ' +
                                        snapshot
                                            .data![index].budgetUtilization!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SelectableText(
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
                                              snapshot
                                                  .data![index].projectName!,
                                              snapshot.data![index]
                                                  .latestInvoiceMonth!,
                                              snapshot.data![index]
                                                  .latestPaymentMonth!,
                                            ]);
                                          },
                                          child: Text('Project Charts')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Get.to(ProjectDocument(),
                                                arguments: [
                                                  snapshot.data![index].id!,
                                                  snapshot.data![index]
                                                      .projectName!,
                                                  snapshot.data![index]
                                                      .latestInvoiceMonth!,
                                                  snapshot.data![index]
                                                      .latestPaymentMonth!,
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
        ));
  }
}
