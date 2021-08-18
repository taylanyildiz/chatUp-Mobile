import 'dart:io';

import 'package:chat_app/dialogs/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  Utils._();

  static showSnacBar(String title, String body) {
    Get.snackbar(
      title,
      body,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      padding: EdgeInsets.all(10.0),
    );
  }

  static showLoadingDialog() {
    Get.dialog(LoadinDialog(), barrierDismissible: false);
  }

  static Future<File?> mediaPicker(
      {bool isGallery = false, required Function(File)? cropImage}) async {
    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final pickerImage = await ImagePicker().pickImage(source: source);
    if (pickerImage == null) return null;
    if (cropImage == null)
      return File(pickerImage.path);
    else
      return cropImage(File(pickerImage.path));
  }
}
