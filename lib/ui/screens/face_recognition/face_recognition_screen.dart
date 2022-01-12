import 'package:flutter/material.dart';

import 'body.dart';

class FaceRecognitionScreen extends StatelessWidget {
  const FaceRecognitionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Body(),
    );
  }
}