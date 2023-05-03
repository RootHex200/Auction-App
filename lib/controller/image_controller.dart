import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var isproductUploadLoading = false.obs;
  List<File> images = <File>[].obs;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFiles = await picker.getMultiImage();
    images.addAll(pickedFiles != null
        ? pickedFiles.map((file) => File(file.path)).toList()
        : []);
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      images.add(File(pickedFile.path));
    }
  }
}
