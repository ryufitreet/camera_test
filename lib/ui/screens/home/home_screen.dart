import 'package:flutter/material.dart';

import '../camera/camera_screen.dart';
import '../face_recognition/face_recognition_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () => _faceRecognitionScreen(context),
            child: Text('Camera + Face Recognition'),
          ),
          TextButton(
            onPressed: () => _cameraScreen(context),
            child: Text('Camera and Gallery'),
          ),
        ],
      ),
    );
  }

  _cameraScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CameraScreen(),
    ));
  }

  _faceRecognitionScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => FaceRecognitionScreen(),
    ));
  }

}