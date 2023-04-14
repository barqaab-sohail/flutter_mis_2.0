import 'package:first_project/controllers/project/search/SearchAllProjectDocuments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/project/ProjectDocumentController.dart';
import '../../controllers/project/search/SearchProjectDocument.dart';
import '../../model/project/ProjectDocumentModel.dart';
import '../drawer/drawer_view_class.dart';
import '../hr/pdf_viewer.dart';
import '../hr/photo_viewer.dart';

class AllProjectDocumentsView extends StatefulWidget {
  const AllProjectDocumentsView({super.key});

  @override
  State<AllProjectDocumentsView> createState() =>
      _AllProjectDocumentsViewState();
}

class _AllProjectDocumentsViewState extends State<AllProjectDocumentsView> {
  DrawerViewClass drawerViewClass = DrawerViewClass();
  final projectDocumentController = Get.put(ProjectDocumentController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('All Project Documents'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: SearchAllProjectDocument());
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
          Expanded(
              child: FutureBuilder<List<ProjectDocumentModel>>(
            future: projectDocumentController.getAllProjectDocuments(),
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
                              snapshot.data![index].extension!),
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
