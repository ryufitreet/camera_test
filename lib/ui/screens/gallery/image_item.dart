import 'dart:io';

import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {

  final File file;

  const ImageItem({
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      fit: BoxFit.cover,
    );
  }

}