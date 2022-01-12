import 'dart:io';

import 'package:flutter/material.dart';

import 'image_item.dart';

class FilesGrid extends StatelessWidget {

  final List<FileSystemEntity> files;

  const FilesGrid({
    Key? key,
    required this.files,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 3,
        children: files.map<Widget>(
          (FileSystemEntity f) => ImageItem(file: File(f.path))
        ).toList(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }

}