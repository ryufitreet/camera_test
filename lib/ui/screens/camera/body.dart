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
        cameraController: _cameraController!
      );
    }
    
  }

  _initCameraController() async {
    List<CameraDescription> cameras = await availableCameras();
    CameraController controller = CameraController(cameras[1], ResolutionPreset.medium);
    await controller.initialize();
    setState(() {
      _cameraController = controller;
    });
  }

}