import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Document View'),
      ),
      body: Container(
          child: Image.network(
              "https://hrms.barqaab.pk/storage/hr/documentation/253-muhammad_zafar/253-cnic%20front-1630925662.JPG")),
    );
  }
}
