import 'dart:io';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/services/storage.dart';
import 'package:calorun/shared/modified_image.dart';
import 'package:calorun/widget/user/search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

class UpdateAvatar extends StatefulWidget {
  final ModifiedUser currentUser;
  UpdateAvatar({this.currentUser});

  @override
  _UpdateAvatarState createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  File image;
  bool isUploading = false;

  Future<void> _getImage() async {
    PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1800,
      maxWidth: 1800,
    );
    this.image = File(imageFile.path);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xff297373),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      image = croppedFile;
    });
  }

  Future<void> _getCaptureImage() async {
    PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1800,
      maxWidth: 1800,
    );

    this.image = File(imageFile.path);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xff297373),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      image = croppedFile;
    });
  }

  Future<void> _removeAvatar() async {
    await StorageServices().removeUserAvatar(widget.currentUser.uid);
    await DatabaseServices(uid: widget.currentUser.uid)
          .updateUserAvatar(null);
    Navigator.of(context).pop();
  }

  Future<void> _uploadAndSave() async {
    setState(() {
      isUploading = true;
    });

    String downloadUrl;
    downloadUrl = null;

    if (image != null) {
      // Compressing image
      final Directory directory = await getTemporaryDirectory();
      final String path = directory.path;
      final Im.Image decodedImage = Im.decodeImage(image.readAsBytesSync());
      final compressedImage = File('$path/avt_${widget.currentUser.uid}.png')
        ..writeAsBytesSync(Im.encodePng(decodedImage));
      image = compressedImage;

      // Upload image
      await StorageServices().removeUserAvatar(widget.currentUser.uid);
      downloadUrl =
          await StorageServices().newAvatar(image, widget.currentUser.uid);
    }

    // Save image
    if (downloadUrl != null) {
      bool result = await DatabaseServices(uid: widget.currentUser.uid)
          .updateUserAvatar(downloadUrl);

      // Upload complete
      if (result) {
        setState(() {
          image = null;
        });
        Navigator.of(context).pop();
      } else {        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Upload failed'),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No new image found'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchUser()),
              );
            },
          ),
        ],

        title: Text(
          "Calorun",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Spantaran",
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff297373),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
            ),
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff297373).withOpacity(0.75),
                      width: 10,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                      image: image == null
                          ? modifiedAvtImageNetwork(widget.currentUser.avtUrl)
                          : FileImage(image),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Color(0xffd6d6d6),
                  width: 80,
                  child: IconButton(
                    icon: Icon(Icons.add_photo_alternate),
                    onPressed: () => _getImage()
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  color: Color(0xffd6d6d6),
                  width: 80,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _getCaptureImage()
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  color: Color(0xffd6d6d6),
                  width: 80,
                  child: IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () => _removeAvatar()
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color(0xff297373).withOpacity(0.6);
                      return Color(0xff297373); // Use the component's default.
                    },
                  ),
                ),
                child: Text(
                  'Change',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _uploadAndSave(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
