import 'package:camera_tests/ui/screens/camera/camera_screen_model.dart';
import 'package:camera_tests/ui/screens/gallery/gallery_screen.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {

  final void Function() switchCamera;

  const ControlPanel({
    Key? key,
    required this.switchCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CameraScreenModel model = CameraScreenModel.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: model.toggleCameraDirection,
                child: Text('Switch camera'),
              ),
              SizedBox(width: 16,),
              ElevatedButton(
                onPressed: model.takePicture,
                child: Text('Take picture'),
              ),
              SizedBox(width: 16,),
              ElevatedButton(
                onPressed: () => _openGallery(context),
                child: Text('Open gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _openGallery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => GalleryScreen(),
      )
    );
  }

}