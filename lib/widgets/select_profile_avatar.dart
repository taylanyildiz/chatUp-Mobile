import 'dart:io';

import 'package:chat_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';

import '/constants/constant.dart';
import 'package:flutter/material.dart';

class SelectProfilePhoto extends StatefulWidget {
  const SelectProfilePhoto({
    Key? key,
    required this.onPressed,
    required this.profileImage,
    required this.onDelete,
    this.backgroundColor,
    this.radius,
    this.addIconBackgroundColor,
  }) : super(key: key);

  final Function(File? imageFile) onPressed;
  final Function() onDelete;
  final Color? backgroundColor;
  final Color? addIconBackgroundColor;
  final double? radius;
  final Image? profileImage;

  @override
  _SelectProfilePhotoState createState() => _SelectProfilePhotoState();
}

class _SelectProfilePhotoState extends State<SelectProfilePhoto> {
  bool isGallery = false;

  Future selectPhoto() async {
    File? file = await Utils.mediaPicker(
      isGallery: isGallery,
      cropImage: croppImage,
    );
    if (file == null)
      return;
    else {
      widget.onPressed.call(file);
    }
    setState(() {});
  }

  Future<File?>? croppImage(File file) async => await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        maxHeight: 100,
        maxWidth: 100,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: androidUiSettingsLock(),
        iosUiSettings: iosUiSettings(),
      );

  AndroidUiSettings androidUiSettingsLock() {
    return AndroidUiSettings(
      lockAspectRatio: false,
      toolbarTitle: 'Select Profile Photo',
      toolbarColor: Colors.black,
      toolbarWidgetColor: Colors.white,
      activeControlsWidgetColor: Colors.white,
      hideBottomControls: true,
      initAspectRatio: CropAspectRatioPreset.square,
    );
  }

  IOSUiSettings iosUiSettings() {
    return IOSUiSettings(
      minimumAspectRatio: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkImage = widget.profileImage != null;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150.0),
        decoration: BoxDecoration(
          color: CustomColors.currentMessageBox,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: -Offset(8.0, 8.0),
              blurRadius: 25.0,
              color: Colors.white.withOpacity(.2),
            ),
            BoxShadow(
              offset: Offset(8.0, 8.0),
              blurRadius: 25.0,
              color: Colors.black,
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: CustomColors.currentMessageBox,
                shape: BoxShape.circle,
              ),
              child: checkImage
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 100.0),
                      child: widget.profileImage,
                    )
                  : Center(
                      child: Icon(
                        Icons.person,
                        size: 60.0,
                      ),
                    ),
            ),
            Positioned(
              right: 20.0,
              bottom: 10.0,
              child: GestureDetector(
                onTap: () {
                  _buildCupertinoSheet(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildCupertinoSheet(BuildContext context) async {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('Select Photo'),
              onPressed: () async {
                isGallery = true;
                await selectPhoto();
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Text('Take Photo'),
              onPressed: () async {
                isGallery = false;
                await selectPhoto();
                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: widget.profileImage != null
              ? CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  child: Text('Delete Photo'),
                  onPressed: () async {
                    widget.onDelete.call();
                    Navigator.pop(context);
                  },
                )
              : SizedBox.shrink(),
        );
      },
    );
  }
}
