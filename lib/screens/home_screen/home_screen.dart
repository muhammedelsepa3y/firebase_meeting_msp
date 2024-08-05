import 'package:firebase_meeting_msp/services/firestore_srevice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Screen'),
          Consumer<FirestoreService>(
            builder: (context, firestoreService, child) {
              if (firestoreService.userModel == null) {
                return CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(firestoreService.userModel!.name.toString(),
                          style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  TextEditingController nameController =
                                  TextEditingController(text: firestoreService.userModel!.name);
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              hintText: 'Name'),
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              if (nameController.text.isEmpty||
                                                  nameController.text ==
                                                      firestoreService.userModel!.name) {
                                                return;
                                              }
                                              await firestoreService.setName(nameController.text);

                                              Navigator.pop(context);
                                            },
                                            child: Text("Save")),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Text("Edit"))
                    ],
                  ),
                  Text(firestoreService.userModel!.age.toString(),
                      style: TextStyle(fontSize: 25)),
                  Text(
                    firestoreService.userModel!.lastLogin.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              );
            },

          ),
          ElevatedButton(
              onPressed: () async {
                await AuthService().logout();
              },
              child: Text("Logout"))
        ],
      ),
    ));
  }
}
