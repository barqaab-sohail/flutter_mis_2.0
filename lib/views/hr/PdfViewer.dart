import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    print("https://hrms.barqaab.pk/storage/" + Get.arguments[0]);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Document View'),
        ),
        body: Container(
          child: SfPdfViewer.network(
              "https://hrms.barqaab.pk/storage/" + Get.arguments[0]),
        ));
  }
}
