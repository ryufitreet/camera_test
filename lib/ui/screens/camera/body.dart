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
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: [
          Camera(
            cameraController: _cameraController!,
            switchDirection: _switchDirection,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: _switchDirection,
                child: Text('Switch camera'),
              ),
            ],
          ),
        ],
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