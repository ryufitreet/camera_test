import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class GalleryModel extends ChangeNotifier {

  List<FileSystemEntity>? files;

  GalleryModel() {
    init();
  }

  init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    
    String photosPath = '${appDocDir.path}/photos';
    Directory photosDir = Directory(photosPath);

    if (photosDir.existsSync()) {
      List<FileSystemEntity> files = photosDir.listSync();
      setFiles(files);
    }

  }

  setFiles(List<FileSystemEntity> list) {
    print('SET FILES');
    files = list;
    notifyListeners();
  }

  static GalleryModel of(BuildContext context)
    => Provider.of<GalleryModel>(context, listen: false);

}