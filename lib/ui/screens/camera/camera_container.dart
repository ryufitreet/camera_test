import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraContainer extends StatelessWidget {

  final CameraController? cameraController;

  const CameraContainer({
    Key? key,
    this.cameraController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CameraPreview(cameraController!),
    );
  }
}