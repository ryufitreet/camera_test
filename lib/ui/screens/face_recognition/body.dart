import 'dart:io';

import 'package:camera_tests/ui/screens/photo/photo_screen.dart';
import 'package:camera_tests/utils/files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:typed_data';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  CameraController? _cameraController;
  CameraDescription? _camera;

  FaceDetector? _faceDetector;
  bool _faceProcessing = false;

  @override
  void initState() {
    super.initState();
    _initCameraController();
    _faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      enableContours: true,
      mode: FaceDetectorMode.accurate,
    ));
    // _printModelManager();
  }

  _printModelManager() async {
    RemoteModelManager remoteModelManager = GoogleMlKit.vision.remoteModelManager();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null)  {
      return Center(
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
        ),
      );
    } else {
      return Column(
        children: [
          Center(child: CameraPreview(_cameraController!)),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _takePicture,
                  child: Text('Take picture'),
                ),
              ],
            ),
          ),
        ],
      );
    }
    
  }

  _initCameraController() async {
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front
    );
    _camera = front;
    // На high камера не помещается в экран эмулятора
    CameraController controller = CameraController(front, ResolutionPreset.medium);
    
    await controller.initialize();



    // Future.delayed(Duration(seconds: 3), () {
    //   controller.startImageStream((CameraImage cameraImage) async {
    //     if (_faceProcessing) return;
    //     _faceProcessing = true;
    //     InputImage inputImage = _getMlKitInputImageFromCameraImage(cameraImage);
        
    //     final List<Face> faces = await _faceDetector!.processImage(inputImage);
    //     print("faces:::::::::::::::::::::::::::::::::::: $faces");
    //     _faceProcessing = false;
    //   });
    // });


    setState(() {
      _cameraController = controller;
    });
  }

  _takePicture() async {
    XFile photo = await _cameraController!.takePicture();
    Directory photosDir = await getPhotosDir();
    String photoPath = '${photosDir.path}/${photo.name}';
    photo.saveTo(photoPath);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => PhotoScreen(photoFile: File(photoPath)),
      )
    );
  }

  // InputImage _getMlKitInputImageFromCameraImage(CameraImage cameraImage) {
  //   print("_getMlKitInputImageFromCameraImage");
  //   // Создаем буффер 
  //   // Write-only buffer for incrementally building a ByteData instance.
  //   // Окей создаем облать, куда будем записывать байты
  //   final WriteBuffer allBytes = WriteBuffer();
  //   // Почему planes засовываются в буффер один за другим?
  //   // Когда там по идее каждый байт из плейна описывает один пиксель. 
  //   // Ладно, может быть просто ml_kit готов к этому и потом распарсит их
  //   // взависимости от размера
  //   for (Plane plane in cameraImage.planes) {
  //     allBytes.putUint8List(plane.bytes);
  //   }
  //   // Собрали значит все плейны в одну пачку байтов.
  //   final Uint8List bytes = allBytes.done().buffer.asUint8List();
  //   print("bytesLength ${bytes.length}");
  //   // Понятно
  //   final Size imageSize = Size(
  //     cameraImage.width.toDouble(),
  //     cameraImage.height.toDouble()
  //   );
  //   print('imageSize $imageSize');
  //   // Тоже вроде понятно
  //   final InputImageRotation imageRotation = 
  //     InputImageRotationMethods.fromRawValue(_camera!.sensorOrientation) ??
  //     InputImageRotation.Rotation_0deg;
  //   print("InputImageRotation ${_camera!.sensorOrientation} ${InputImageRotationMethods.fromRawValue(_camera!.sensorOrientation)}");
  //   print('ImageFormatRaw ${cameraImage.format.raw} ${InputImageFormatMethods.fromRawValue(cameraImage.format.raw)}');
  //   // Тоже вроде понятно, но с format.raw могут быть сложности.
  //   // Так как на Андроиде это инт а на иос что-то еще
  //   final InputImageFormat inputImageFormat = 
  //     InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
  //       InputImageFormat.BGRA8888;
  //   // Собираем из каждого Plane основные данные
  //   final List<InputImagePlaneMetadata> planeData = cameraImage.planes.map<InputImagePlaneMetadata>(
  //     (Plane plane) => InputImagePlaneMetadata(
  //       bytesPerRow: plane.bytesPerRow,
  //       height: cameraImage.width,
  //       width: cameraImage.height,
  //     )
  //   ).toList();
  //   planeData.forEach((pd) {
  //     print("PlaneData $pd pd w:${pd.width} h:${pd.height}");
  //   });
  //   // Собираем все данные для составления картинки
  //   final InputImageData inputImageData = InputImageData(
  //     size: imageSize,
  //     imageRotation: imageRotation,
  //     inputImageFormat: inputImageFormat,
  //     planeData: planeData,
  //   );
  //   print("InputImageData:::::::::::::::: ${inputImageData.getMetaData()}");

  //   // Собираем картинку для обратки MLKIT
  //   final InputImage inputImage = InputImage.fromBytes(
  //     bytes: bytes,
  //     inputImageData: inputImageData
  //   );
  //   // ни че го непонятно
  //   // Окей, это как-то работает
  //   /* 06.01.22 нихуя не понятно. Ничего не работает. Сначала сделаю галерею.
  //     Разберусь как загружать\сохранять показывать фотки. Потом вернусь сюда.
  //     Хотя бы можно будет как-то отдебажить.
  //   */
  //   return inputImage;
  // }

}