// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:plxn_task/models/user_model.dart';
import 'package:plxn_task/screens/users_list.dart';

final db = FirebaseFirestore.instance;

void addUser({
  age,
  gender,
  email,
  gstNumber,
  phone,
}) async {
  final docRef = db.collection('users').doc();
  UserModel user = UserModel(
    id: docRef.id,
    age: age,
    gender: gender,
    email: email,
    gstNumber: gstNumber,
    phone: phone,
  );

  await docRef.set(user.toJson()).then((value) {
    log("User added successfully!");
    Get.offAll(() => UsersList());
  }, onError: (e) => log("Error adding user: $e"));
}

getUsers() {
  return db.collection('users').snapshots();
}
