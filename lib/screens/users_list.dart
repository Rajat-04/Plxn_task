import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plxn_task/contollers/firebaseControl.dart';
import 'package:plxn_task/models/user_model.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Users"),
        ),
        body: StreamBuilder(
          stream: getUsers(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null) {
              return const SizedBox();
            }

            if (snapshot.hasData) {
              List<UserModel> userList = [];
              for (var doc in snapshot.data!.docs) {
                final user =
                    UserModel.fromJson(doc.data() as Map<String, dynamic>);
                userList.add(user);
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.bottomSheet(Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(userList[index].imageUrl!),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Age : ${userList[index].age}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:
                                    Text("Gender : ${userList[index].gender}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Email : ${userList[index].email}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                    "GST Number : ${userList[index].gstNumber}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                    "Phone Number : ${userList[index].phone}"),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.person,
                        ),
                        title: Text(
                          userList[index].email.toString(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
