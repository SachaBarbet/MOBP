import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utilities/remote_database.dart';

class AddFolder extends StatelessWidget {
  const AddFolder({super.key});

  @override
  Widget build(BuildContext context) {
    late String name, description;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void leavePage() {
      Navigator.pop(context);
    }

    Future<void> addFolder() async {
      FormState? formState = formKey.currentState!;
      if(formState.validate()) {
        formState.save();
        await RemoteDatabase.db.collection('Folders')
            .doc(AppUser.id)
            .collection('ListFolders')
            .add({"name": name, "description": description});
        leavePage();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF262525),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text('New Folder', style: TextStyle(color: Colors.white, fontSize: 36)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type a name for your new folder !';
                      } else if (value.length > 200) {
                        return '';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value!,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    onSaved: (value) => description = value!,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          await addFolder();
                        },
                        child: const Text('ADD', style: TextStyle(color: Color(0xFFEAC435), fontSize: 20),)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}
