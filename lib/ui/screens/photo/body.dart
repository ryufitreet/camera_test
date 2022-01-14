import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera_tests/ui/painters/face_points_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:camera_tests/ui/painters/square_painter.dart';
import 'package:camera_tests/ui/screens/photo/photo_screen_model.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class Body extends StatefulWidget {

  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool _recognitionLoading = false;

  Widget? faceSquare;
  Widget? facePoints;

  GlobalKey imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoScreenModel>(
      builder: (_, m, __) => SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.file(
                      m.photoFile,
                      key: imageKey,
                    ),
                    if (faceSquare != null) faceSquare!,
                    if (facePoints != null) facePoints!,
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _recognitionLoading ? null : _faceRecognite,
                        child: Text('Face Recognite'),
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Future<Size> _getImageSize() async {
    File imageFile = Provider.of<PhotoScreenModel>(
      context, listen: false
    ).photoFile;
    ui.Image img = await decodeImageFromList(imageFile.readAsBytesSync());

    return Size(img.width.toDouble(), img.height.toDouble());
  }

  _faceRecognite() async {
    setState(() => _recognitionLoading = true);
    FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableClassification: true,
        enableLandmarks: true,
        enableContours: true,
        mode: FaceDetectorMode.accurate,
      )
    );

    File photoFile = Provider.of<PhotoScreenModel>(context, listen: false).photoFile;

    InputImage inputImage = InputImage.fromFile(photoFile);
    List<Face> faces = await _faceDetector.processImage(inputImage);

    setState(() => _recognitionLoading = false);

    for (Face face in faces) {
      // setState(() {
      //   // faceRect = face.getContour(FaceContourType.face);
      //   faceRect = face.boundingBox;
      // });
      print(face.boundingBox);
      // _buildSquarePaint(face.boundingBox);
      List<Offset> facePointsOval = face.getContour(FaceContourType.face)!.positionsList;
      _bulidFacePointsOval(facePointsOval);
      // print(face.getContour(FaceContourType.face)?.positionsList);
    }
  }

  Future<double> _getScaleFactor() async {
    Size imageSize = await _getImageSize();
    Size? previewImageWidth = imageKey.currentContext?.size;
    double factor = previewImageWidth!.width / imageSize.width;
    return factor;
  }

  Rect _scaleTheRect(Rect rect, double scaleFactor) {
    return Rect.fromLTRB(
      rect.left * scaleFactor,
      rect.top * scaleFactor, 
      rect.right * scaleFactor, 
      rect.bottom * scaleFactor
    );
  }

  List<Offset> _scaleThePoints(List<Offset> points, double scaleFactor) {
    List<Offset> offsetList = [];
    for (Offset p in points) {
      offsetList.add(Offset(p.dx * scaleFactor, p.dy * scaleFactor));
    }
    return offsetList;
  }

  Future<void> _buildSquarePaint(Rect faceRect) async {
    double scaleFactor = await _getScaleFactor();
    setState(() {
      faceSquare = CustomPaint(
        painter: SquarePainter(
          squareRect: _scaleTheRect(faceRect, scaleFactor),
        ),
      );  
    });
  }

  Future<void> _bulidFacePointsOval(List<Offset> points) async {
    double scaleFactor = await _getScaleFactor();
    setState(() {
      facePoints = CustomPaint(
        painter: FacePointsOvalPainter(
          points: _scaleThePoints(points, scaleFactor),
        ),
      );
    });
  }

}