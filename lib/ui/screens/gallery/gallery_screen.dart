import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gallery_model.dart';
import 'body.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GalleryModel>(
      create: (_) => GalleryModel(),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
        ),
        body: Body(),
      ),
    );
  }
}