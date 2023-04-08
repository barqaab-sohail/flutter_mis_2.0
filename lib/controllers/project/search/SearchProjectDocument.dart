import 'package:first_project/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/project/ProjectDocumentModel.dart';
import '../../../views/hr/PdfViewer.dart';
import '../../../views/hr/PhotoViewer.dart';
import '../ProjectDocumentController.dart';

class SearchProjectDocument extends SearchDelegate {
  final projectDocumentController = Get.find<ProjectDocumentController>();

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
    return FutureBuilder<List<ProjectDocumentModel>>(
      future: projectDocumentController.getProjectDocuments(
          id: projectId.toString(), query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                onTap: () {
                  String url = snapshot.data![index].path! +
                      snapshot.data![index].fileName!;
                  String fileName = snapshot.data![index].description!;
                  if (snapshot.data![index].extension == 'pdf') {
                    Get.to(() => PdfViewer(), arguments: [url, fileName]);
                  } else {
                    Get.to(() => PhotoViewer(), arguments: [url, fileName]);
                  }
                },
                title: Text(snapshot.data![index].description!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Document Date: ' + snapshot.data![index].extension!),
                    Text('Extension Type: ' + snapshot.data![index].extension!),
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
    );
  }
}
