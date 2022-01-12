import 'package:camera_tests/ui/screens/camera/camera_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'body.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CameraScreenModel>(
      create: (_) => CameraScreenModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Camera And Gallery'),
        ),
        body: Body(),
      ),
    );
  }
}