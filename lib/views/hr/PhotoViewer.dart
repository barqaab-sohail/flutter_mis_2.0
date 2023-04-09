import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../helper/dialog_helper.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

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
                showLoading('Please wait ...');
                final response = await http.get(url);
                final bytes = response.bodyBytes;
                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(bytes);
                hideLoading();
                await Share.shareFiles([path], text: fileName);
              },
              icon: Icon(Icons.share),
            )
          ],
        ),
        body: Container(
          child: CachedNetworkImage(
            imageUrl: StoragePoint.storage + Get.arguments[0],
            placeholder: (context, url) =>
                Center(child: new CircularProgressIndicator()),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          // Image.network(StoragePoint.storage + Get.arguments[0]),
        ));
  }
}
