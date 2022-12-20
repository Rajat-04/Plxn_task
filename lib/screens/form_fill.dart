// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_new, unnecessary_null_comparison, prefer_final_fields, unused_field, unused_import

import 'dart:developer';
import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plxn_task/models/user_model.dart';
import 'package:plxn_task/screens/users_list.dart';
import 'package:plxn_task/contollers/firebaseControl.dart';

class FormFill extends StatefulWidget {
  const FormFill({super.key});

  @override
  State<FormFill> createState() => _FormFillState();
}

class _FormFillState extends State<FormFill> {
  File? imageFile;
  bool showSpinner = false;
  var _ageController = TextEditingController();
  var _genderController = TextEditingController();
  var _emailController = TextEditingController();
  var _gstController = TextEditingController();
  var _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Form"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  imageFile == null
                      ? InkWell(
                          onTap: () {
                            showBottomSheet();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 64,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: showBottomSheet,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(imageFile!),
                          ),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'Age',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextField(
                        controller: _genderController,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'Gender',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'Email Id',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextField(
                        controller: _gstController,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'GST Number',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: ElevatedButton(
                      onPressed: () {
                        addUser(
                          age: _ageController.text,
                          gender: _genderController.text,
                          email: _emailController.text,
                          gstNumber: _gstController.text,
                          phone: _phoneController.text,
                          imageUrl: imageFile,
                        );
                      },
                      child: Center(
                        child: Text("GO"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Select From",
                  style: TextStyle(fontSize: 22),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _getImage("camera"),
                      icon: Icon(
                        Icons.camera_alt,
                        size: 32,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _getImage("gallery"),
                      icon: Icon(
                        Icons.file_copy,
                        size: 32,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImage(String select) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: select == "camera" ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Get.back();
  }
}
