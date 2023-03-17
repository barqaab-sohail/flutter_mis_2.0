import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:first_project/utils/api/BaseAPI.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  bool isLoading = true;
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
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(bytes);
                isLoading = false;
                await Share.shareFiles([path], text: fileName);
              },
              icon: Icon(Icons.share),
            )
          ],
        ),
        body: Container(
          child: Image.network(StoragePoint.storage + Get.arguments[0]),
        ));
  }
}
