import 'dart:io';

import 'package:camera_tests/ui/screens/photo/photo_screen.dart';
import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {

  final File file;

  const ImageItem({
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPhoto(context),
      child: Image.file(
        file,
        fit: BoxFit.cover,
      ),
    );
  }

  _openPhoto(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => PhotoScreen(photoFile: file),
      )
    );
  }

}