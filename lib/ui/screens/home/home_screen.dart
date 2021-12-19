import 'package:camera_tests/ui/screens/camera/camera_screen.dart';
import 'package:flutter/material.dart';

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
        children: [
          TextButton(
            onPressed: () => _cameraScreen(context),
            child: Text('Camera'),
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