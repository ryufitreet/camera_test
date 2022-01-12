import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getPhotosDir() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  
  return Directory('${appDir.path}/photos');
}