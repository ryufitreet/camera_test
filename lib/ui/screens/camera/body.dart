import 'package:camera_tests/ui/screens/camera/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'camera.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  CameraController? _cameraController;
  CameraLensDirection _cameraLensDirection = CameraLensDirection.back;

  @override
  initState() {
    super.initState();
    _initCameraController();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Camera(
        cameraController: _cameraController!,
        switchDirection: _switchDirection,
      );
    }
    
  }

  _initCameraController() async {
    _cameraController = null;
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription descr = cameras.firstWhere(
      (descr) => descr.lensDirection == _cameraLensDirection
    );
    
    CameraController controller = CameraController(
      descr,
      ResolutionPreset.medium,
    );
    
    await controller.initialize();
    setState(() {
      _cameraController = controller;
    });
  }

  void _switchDirection() {
    if (_cameraLensDirection == CameraLensDirection.front) {
      _cameraLensDirection = CameraLensDirection.back;
    } else {
      _cameraLensDirection = CameraLensDirection.front;
    }
    _initCameraController();
  }

}