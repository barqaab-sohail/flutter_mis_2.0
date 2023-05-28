import 'package:first_project/main.dart';
import 'package:first_project/views/hr/photo_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/views/hr/pdf_viewer.dart';
import '../../controllers/project/ProjectDocumentController.dart';
import '../../controllers/project/search/SearchProjectDocument.dart';
import '../../model/project/ProjectDocumentModel.dart';

class ProjectDocument extends StatefulWidget {
  const ProjectDocument({super.key});

  @override
  State<ProjectDocument> createState() => _ProjectDocumentState();
}

class _ProjectDocumentState extends State<ProjectDocument> {
  final projectDocumentController = Get.put(ProjectDocumentController());

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
    projectId = Get.arguments[0];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Get.arguments[1] + ' Documents'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchProjectDocument());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: FutureBuilder<List<ProjectDocumentModel>>(
            future: projectDocumentController.getProjectDocuments(
                id: Get.arguments[0].toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      onTap: () {
                        String url = snapshot.data![index].path! +
                            snapshot.data![index].fileName!;
                        String fileName = snapshot.data![index].description!;
                        if (snapshot.data![index].extension == 'pdf') {
                          Get.to(() => PdfViewer(), arguments: [url, fileName]);
                        } else {
                          Get.to(() => PhotoViewer(),
                              arguments: [url, fileName]);
                        }
                      },
                      title: Text(snapshot.data![index].description!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Document Date: ' +
                              snapshot.data![index].documentDate!),
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
