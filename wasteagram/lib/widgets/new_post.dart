import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wasteagram/models/firestore_post_model.dart';

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  LocationData locationData;
  var locationService = Location();
  String image;
  File imgPath;
  int quantity;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
    _getImage();
  }

  void _getImage() async {
    final PickedFile imagePicked =
        await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imagePicked != null) {
        image = File(imagePicked.path).toString();
        imgPath = File(imagePicked.path);
      }
    });
  }

  void _uploadImageAndDocument() async {
    DateTime timestamp = DateTime.now();
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${timestamp.millisecondsSinceEpoch}.jpg');
    DateFormat dateFormat = DateFormat.yMMMMEEEEd();
    String string = dateFormat.format(DateTime.now()).toString();
    StorageUploadTask uploadTask = storageReference.putFile(imgPath);
    await uploadTask.onComplete;

    //var dowurl = await storageReference.getDownloadURL();
    //String url = dowurl.toString();
    //var durl = await storageReference.getDownloadURL();
    final url = await storageReference.getDownloadURL().toString();

    if (locationData == null) {
      print('LOCATION DATA IS NULL');
    }
    PostDocument post = PostDocument(url, locationData.latitude.toString(),
        locationData.longitude.toString(), quantity, string);
    post.upload();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('FAILED to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('LOCATION service permission not granted. Returning.');
        }
      }
      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('ERROR: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.file(imgPath),
                SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Semantics(
                    enabled: true,
                    onTapHint: "Enter number of wasted items",
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number of Wasted Items',
                        border: OutlineInputBorder(),
                      ),
                      textAlign: TextAlign.center,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a number';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        quantity = int.parse(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ButtonTheme(
                  minWidth: 400.0,
                  height: 100.0,
                  child: Semantics(
                    button: true,
                    enabled: true,
                    onTapHint: 'Upload',
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.cloud_upload, size: 50,
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          _uploadImageAndDocument();
                          Navigator.of(context).pop(true);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
