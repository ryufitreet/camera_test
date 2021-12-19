import 'package:flutter/material.dart';
import 'package:camera_tests/ui/screens/camera/camera_screen.dart';

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
            onPressed: () => _cameraScreen(context),
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () => _cameraScreen(context),
            child: Text('Camera + Face Recognition'),
          ),
          TextButton(
            onPressed: () => _cameraScreen(context),
            child: Text('Camera + Photo Gallery'),
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

}