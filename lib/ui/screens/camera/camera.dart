import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatelessWidget {

  final CameraController? cameraController;

  const Camera({
    Key? key,
    this.cameraController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CameraPreview(cameraController!),
        TextButton(
          onPressed: () => print('TODO Change camera'),
          child: Text('Switch camera'),
        ),
      ],
    );
  }
}

