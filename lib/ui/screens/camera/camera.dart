import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatelessWidget {

  final CameraController? cameraController;
  final Function()? switchDirection;

  const Camera({
    Key? key,
    this.cameraController,
    this.switchDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CameraPreview(cameraController!),
        TextButton(
          onPressed: switchDirection,
          child: Text('Switch camera'),
        ),
      ],
    );
  }
}

