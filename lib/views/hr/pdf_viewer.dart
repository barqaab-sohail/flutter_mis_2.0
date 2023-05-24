import 'dart:io';
import 'package:first_project/helper/unauthorized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../helper/dialog_helper.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool isShareAllowed = false;

  loadUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> permissions = sp.getStringList('permissions')!;
    isShareAllowed = permissions.contains('mis share doc');
  }

  String fileName = '';
  String path = '';
  @override
  void initState() {
    super.initState();
    loadUserData();
    //getPdf();
  }

  // getPdf() async {
  //   fileName = Get.arguments[1];
  //   final UrlImage = StoragePoint.storage + Get.arguments[0];
  //   final url = Uri.parse(UrlImage);
  //   final response = await http.get(url);
  //   final bytes = response.bodyBytes;
  //   final temp = await getTemporaryDirectory();
  //   path = '${temp.path}/${fileName}.pdf';
  //   File(path).writeAsBytesSync(bytes);
  // }

  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

  Widget pdfView() {
    return SfPdfViewer.network(
      StoragePoint.storage + Get.arguments[0],
    );
  }

  Future<File> getPdfFile() async {
    String fileName = Get.arguments[1];
    final UrlImage = StoragePoint.storage + Get.arguments[0];
    final url = Uri.parse(UrlImage);
    final response = await http.get(url);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    path = '${temp.path}/${fileName}.pdf';
    File(path).writeAsBytesSync(bytes);
    return File(path);
  }

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
                isShareAllowed
                    ?
                    // String fileName = Get.arguments[1];
                    // final UrlImage = StoragePoint.storage + Get.arguments[0];
                    // showLoading('Please wait ...');
                    // // final url = Uri.parse(UrlImage);
                    // // final response = await http.get(url);
                    // // final bytes = response.bodyBytes;
                    // // final temp = await getTemporaryDirectory();
                    // // final path = '${temp.path}/${fileName}.pdf';
                    // // print(path);
                    // File(path).writeAsBytesSync(bytes);
                    // hideLoading();
                    await Share.shareFiles([path], text: fileName)
                    : UnAuthorized.authError();
              },
              icon: Icon(Icons.share),
            )
          ],
        ),
        body: Container(
            child: FutureBuilder(
                future: getPdfFile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SfPdfViewer.file(snapshot.data!);
                    //SfPdfViewer.network(
                    // 'https://hrms.barqaab.pk/storage/project/96/contract_agreement-1677653796.pdf');
                    //SfPdfViewer.asset('assets/images/contract.pdf');

                    //
                  }
                  return Center(child: const CircularProgressIndicator());
                })
            //     PDF().cachedFromUrl(
            //   StoragePoint.storage + Get.arguments[0],
            //   placeholder: (progress) => Center(child: Text('$progress %')),
            //   errorWidget: (error) => Center(child: Text(error.toString())),
            // )

            ));
  }
}
