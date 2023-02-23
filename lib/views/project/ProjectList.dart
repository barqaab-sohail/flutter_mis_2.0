import 'package:first_project/controllers/project/ProjectListController.dart';
import 'package:first_project/modal/project/ProjectListModal.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../drawer/Drawer.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final projectListController = Get.put(ProjectListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Project List'),
        ),
        drawer: HomeDrawer(),
        body: FutureBuilder<List<ProjectListModal>>(
          future: projectListController.ProjectList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(snapshot.data![index].projectName!),
                          Text(snapshot.data![index].projectType!),
                          Text(snapshot.data![index].paymentReceived!),
                          Text(snapshot.data![index].pendingPayments!),
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}
