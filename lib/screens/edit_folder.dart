import 'package:flutter/material.dart';

import '../models/folder.dart';
import '../utilities/remote_database.dart';

class EditFolder extends StatelessWidget {
  const EditFolder({super.key, required this.folder});
  final AppFolder folder;

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
        await RemoteDatabase.getUserData().collection('ListFolders').doc(folder.id).update({
          "name": name,
          "description": description
        });
        leavePage();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF262525),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF262525),
          leading: BackButton(
            color: Colors.white,
            onPressed: leavePage,
          ),
        ),
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
                    child: Text('Edit Folder', style: TextStyle(color: Colors.white, fontSize: 36)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type a name for your folder !';
                      } else if (value.length > 200) {
                        return '';
                      }
                      return null;
                    },
                    initialValue: folder.name,
                    onSaved: (value) => name = value!,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    ),
                  ),
                  TextFormField(
                    onSaved: (value) => description = value!,
                    style: const TextStyle(color: Colors.white),
                    initialValue: folder.description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          await addFolder();
                        },
                        child: const Text('EDIT', style: TextStyle(color: Color(0xFFEAC435), fontSize: 20),)
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
