// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:plxn_task/models/user_model.dart';
import 'package:plxn_task/screens/users_list.dart';

final db = FirebaseFirestore.instance;
final storage_reference = FirebaseStorage.instance.ref().child('images');
final fileName = DateTime.now().millisecondsSinceEpoch.toString();
final imgUpload = storage_reference.child(fileName);
String? imagePath;

void addUser({
  age,
  gender,
  email,
  gstNumber,
  phone,
  imageUrl,
}) async {
  final docRef = db.collection('users').doc();

  if (age != null &&
      gender != null &&
      email != null &&
      gstNumber != null &&
      phone != null &&
      imageUrl != null) {
    try {
      await imgUpload.putFile(File(imageUrl!.path));
      imagePath = await imgUpload.getDownloadURL();
    } on Exception catch (e) {
      Get.snackbar("Some Error Occured", "Please Try Again");
      return;
    }

    UserModel user = UserModel(
      id: docRef.id,
      age: age,
      gender: gender,
      email: email,
      gstNumber: gstNumber,
      phone: phone,
      imageUrl: imagePath,
    );

    await docRef.set(user.toJson(imagePath)).then((value) {
      Get.snackbar("User added successfully!", "");
      Get.offAll(() => UsersList());
    }, onError: (e) => log("Error adding user: $e"));
  } else {
    Get.snackbar("All field Required!", "Fill Empty fields or Select photo");
  }
}

getUsers() {
  return db.collection('users').snapshots();
}
