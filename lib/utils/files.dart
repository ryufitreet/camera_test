import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getPhotosDir() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  
  Directory photosDir = Directory('${appDir.path}/photos');
  if (!(await photosDir.exists())) photosDir.create(recursive: true);
  return photosDir;
}