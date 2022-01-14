import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_tests/utils/files.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CameraScreenModel extends ChangeNotifier {

  CameraController? cameraController;
  CameraLensDirection cameraDirection = CameraLensDirection.back;

  initCameraController() async {
    cameraController?.dispose();
    cameraController = null;
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription descr = cameras.firstWhere(
      (descr) => descr.lensDirection == cameraDirection
    );
    
    CameraController controller = CameraController(
      descr,
      ResolutionPreset.medium,
    );

    await controller.initialize();

    setCameraController(controller);
  }

  setCameraController(CameraController cntrl) {
    cameraController = cntrl;
    notifyListeners();
  }

  toggleCameraDirection() {
    if (cameraDirection == CameraLensDirection.front) {
      cameraDirection = CameraLensDirection.back;
    } else {
      cameraDirection = CameraLensDirection.front;
    }
    initCameraController();
  }

  disposeCameraController() {
    if (cameraController != null) {
      cameraController!.dispose();
    }
  }

  takePicture() async {
    if (cameraController == null) return;
    XFile photo = await cameraController!.takePicture();
    
    Directory photosDir = await getPhotosDir();
    photo.saveTo('${photosDir.path}/${photo.name}');
  }

  static CameraScreenModel of(BuildContext context) {
    return Provider.of<CameraScreenModel>(context, listen: false);
  }

}