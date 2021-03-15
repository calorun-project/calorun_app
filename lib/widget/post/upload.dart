import 'dart:io';
import 'package:calorun/services/database.dart';
import 'package:calorun/services/location.dart';
import 'package:calorun/services/storage.dart';
import 'package:calorun/shared/constants.dart';
import 'package:calorun/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';

class UploadWidget extends StatefulWidget {
  final String uid;
  UploadWidget({this.uid});
  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File image;
  String pid = Uuid().v4();
  TextEditingController descriptionController = TextEditingController();
  String location = '';
  bool isUpLoading = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    String getLocation = await LocationServices().getCurrentAddress();
    setState(() {
      location = getLocation;
    });
  }

  Future<void> _getImage() async {
    PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 680,
      maxWidth: 970,
    );
    setState(() {
      this.image = File(imageFile.path);
    });
  }

  Future<void> _getCaptureImage() async {
    PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      this.image = File(imageFile.path);
    });
  }

  Future<void> _uploadAndSave() async {
    setState(() {
      isUpLoading = true;
    });

    // Compressing image
    final Directory directory = await getTemporaryDirectory();
    final String path = directory.path;
    final Im.Image decodedImage = Im.decodeImage(image.readAsBytesSync());
    final compressedImage = File('$path/img_$pid.png')
      ..writeAsBytesSync(Im.encodeJpg(decodedImage, quality: 90));
    image = compressedImage;

    // Get uploaded image URL
    String downloadUrl = await StorageServices().uploadPostImage(image, pid);

    // Save post info to Firestore
    await DatabaseServices(uid: widget.uid)
        .updatePostData(pid, downloadUrl, descriptionController.text, location);

    // Display the post
    // Upload complete
    setState(() {
      pid = Uuid().v4();
      isUpLoading = false;
      descriptionController.clear();
      location = '';
      image = null;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            isUpLoading ? linearProgress() : Text(''),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff6c807b)),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextField(
                controller: descriptionController,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Say somthing?',
                ),
              ),
            ),
            SizedBox(
              height: 5.00,
            ),
            Text(
              location,
              style: TextStyle(
                  color: Color(0xff297373).withOpacity(0.6), fontSize: 14.0),
            ),
            image == null
                ? Text('')
                : Container(
                    height: 230.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(image), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 5.00,
            ),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add_photo_alternate),
                    onPressed: _getImage),
                IconButton(
                    icon: Icon(Icons.camera_alt), onPressed: _getCaptureImage),
                IconButton(
                    icon: Icon(location == ''
                        ? Icons.location_on
                        : Icons.location_off),
                    onPressed: () {
                      if (location != '') {
                        setState(() {
                          location = '';
                        });
                      } else {
                        _getUserLocation();
                      }
                    }),
              ],
            ),
            ElevatedButton(
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
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _uploadAndSave();
              },
            )
          ],
        ),
      ),
    ));
  }
}
