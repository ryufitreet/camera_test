import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'body.dart';
import 'photo_screen_model.dart';

class PhotoScreen extends StatelessWidget {

  final File photoFile;

  const PhotoScreen({
    Key? key,
    required this.photoFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotoScreenModel>(
      create: (_) => PhotoScreenModel(photoFile: photoFile),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Photo'),
        ),
        body: Body(),
      ),
    );
  }
}