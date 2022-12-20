import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                    onTap: () {},
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
