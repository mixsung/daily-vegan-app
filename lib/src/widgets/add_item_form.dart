import 'dart:io';

import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:daily_vegan_app/src/res/custom_form_field.dart';
import 'package:daily_vegan_app/src/utils/validator.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode recipeFocusNode;

  const AddItemForm({
    required this.nameFocusNode,
    required this.recipeFocusNode,
  });

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final ImagePicker _picker = ImagePicker();
  // late PickedFile file;
  File? _image;

  // 갤러리에서 사진 가져오기
  pickImageFromGallery() async {
    Navigator.pop(context);
    final imageFile = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 300, maxWidth: 650);
    setState(() {
      // this.file = imageFile as PickedFile;
      _image = File(imageFile!.path);
    });
  }

  // Future getImage() async {
  //   var image = await _picker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = File(image!.path);
  //   });
  // }

  // 사진 찍어서 가져오기
  captureImageWithCamera() async {
    Navigator.pop(context);
    final imageFile = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 650, maxHeight: 300);
    // final fDirectory = await getTemporaryDirectory();
    // final path = fDirectory.path;
    setState(() {
      _image = File(imageFile!.path);
    });
  }

  // controlUploadAndSave() async {
  //   setState(() {
  //     uploading = true;
  //   });
  //   await compressingPhoto();
  //   String downloadUrl = await uploadPhoto(imgFile);
  //   savePostInfoToFireStore(
  //       url: downloadUrl,
  //       location: loacationTextEditingController.text,
  //       desc: descTextEditingController.text);
  //   clearPostInfo();
  // }
  //
  // compressingPhoto() async {
  //   final fDirectory = await getTemporaryDirectory();
  //   final path = tDirectory.path;
  //   ImD.Image mImageFile = ImD.decodeImage(imgFile.readAsBytesSync());
  //   final compressedImageFile = File('$path/img_$postId.jpg')
  //     ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 90));
  //   setState(() {
  //     imgFile = compressedImageFile;
  //   });
  // }

  bool isChecked = false;

  final _addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _recipeController = TextEditingController();

  var createDate = DateFormat('yyyy.MM.dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addItemFormKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 80, right: 80),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1)),
                        child: IconButton(
                          icon: Icon(Icons.add_photo_alternate, size: 50),
                          color: Colors.grey,
                          onPressed: () {
                            takeImage(context);
                          },
                        )),
                    SizedBox(height: 20),
                    // Row(children: <Widget>[
                    //   Text('채식인가요?',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontFamily: 'NotoSerifKR',
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 15.0)),
                    //   Checkbox(
                    //     value: isChecked,
                    //     onChanged: (bool? value) {
                    //       setState(() {
                    //         isChecked = value!;
                    //       });
                    //     },
                    //   )
                    // ]),
                    CustomFormField(
                        isLabelEnabled: false,
                        controller: _nameController,
                        focusNode: widget.nameFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: '제목',
                        hint: '제목 또는 음식 이름',
                        validator: (value) =>
                            Validator.validateField(value: value)),
                    CustomFormField(
                        maxLines: 9,
                        isLabelEnabled: false,
                        controller: _recipeController,
                        focusNode: widget.recipeFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        label: 'recipe',
                        hint: '짧은 기록, 레시피를 적어도 좋아요.',
                        validator: (value) =>
                            Validator.validateField(value: value))
                  ],
                )),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ))
                : Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () async {
                        widget.nameFocusNode.unfocus();
                        widget.recipeFocusNode.unfocus();

                        final firebaseStorageRef = FirebaseStorage.instance
                            .ref()
                            .child('post')
                            .child(
                                '${DateTime.now().millisecondsSinceEpoch}.png');

                        final uploadTask = firebaseStorageRef.putFile(_image!,
                            SettableMetadata(contentType: 'image/png'));

                        await uploadTask.whenComplete(() => null);

                        final downloadUrl =
                            await firebaseStorageRef.getDownloadURL();

                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          await Database.addItem(
                            name: _nameController.text,
                            recipe: _recipeController.text,
                            date: createDate,
                            photoUrl: downloadUrl,
                          );

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text('완료',
                            style: TextStyle(
                                fontFamily: 'NotoSerifKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.black)),
                      ),
                    ))
          ],
        ));
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text('New Post'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Capture Image with Camera'),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: Text('Select Image with Gallery'),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
