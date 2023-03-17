import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Document View'),
          actions: [
            IconButton(
              onPressed: () async {
                String fileName = Get.arguments[1];
                final UrlImage = StoragePoint.storage + Get.arguments[0];
                final url = Uri.parse(UrlImage);
                final response = await http.get(url);
                final bytes = response.bodyBytes;

                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/${fileName}.pdf';
                File(path).writeAsBytesSync(bytes);
                await Share.shareFiles([path], text: fileName);
              },
              icon: Icon(Icons.share),
            )
          ],
        ),
        body: Container(
          child: SfPdfViewer.network(StoragePoint.storage + Get.arguments[0]),
        ));
  }
}
