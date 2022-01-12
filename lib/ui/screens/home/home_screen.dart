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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonTheme(
              height: 200,
              child: OutlinedButton(
                onPressed: () => _faceRecognitionScreen(context),
                child: Container(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: Text('Camera + Face Recognition',)
                ),
              ),
            ),
            SizedBox(height: 25,),
            OutlinedButton(
              onPressed: () => _cameraScreen(context),
              child: Container(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: Text('Camera and Gallery'),
              ),
            ),
          ],
        ),
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