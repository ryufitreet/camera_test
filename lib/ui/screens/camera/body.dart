import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:camera_tests/ui/screens/camera/camera_screen_model.dart';

import 'camera.dart';
import 'control_panel.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  CameraScreenModel? model;

  @override
  initState() {
    super.initState();
    model = CameraScreenModel.of(context);
    model?.initCameraController();
  }

  @override
  void dispose() {
    model?.disposeCameraController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<CameraScreenModel>(
      builder: (_, m, __) {
        if (m.cameraController == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Camera(
                  cameraController: m.cameraController!,
                ),
              ),
              ControlPanel(
                switchCamera: m.toggleCameraDirection,
              ),
            ],
          );
        }
      },
    );
  }

}