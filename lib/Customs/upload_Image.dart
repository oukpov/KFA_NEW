import 'dart:io';

import 'package:admin/components/contants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key, required this.com_id}) : super(key: key);
  final String com_id;
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  // ignore: prefer_final_fields
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Image_KFA_2@23');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          margin: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextButton(
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              print('${file?.path}');

              if (file == null) return;
              //Import dart:core
              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages =
                  referenceRoot.child('${widget.com_id}+i');
              Reference referenceImageToUpload =
                  referenceDirImages.child('name');
              try {
                await referenceImageToUpload.putFile(File(file.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
              } catch (error) {}
              if (imageUrl != null) {
                setState(() {
                  String itemName = widget.com_id.toString();
                  Map<String, String> dataToSend = {
                    'com_id': itemName,
                    'image': imageUrl,
                  };
                  _reference.add(dataToSend);
                });
              }
            },
            child: Row(
              children: const [
                Icon(
                  Icons.file_present_sharp,
                  color: kImageColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Choose Image',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
