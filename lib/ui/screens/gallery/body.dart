import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gallery_model.dart';

import 'files_grid.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryModel>(
      builder: (_, m, __) {
        if (m.files != null) {
          return FilesGrid(
            files: m.files!,
          );
        }
        return SizedBox();
      },
    );
  }
}