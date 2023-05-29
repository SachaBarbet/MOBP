import 'package:flutter/material.dart';
import 'package:mobp/utilities/remote_database.dart';
import 'package:mobp/widgets/dropdown_widget.dart';

import '../models/folder.dart';
import '../models/process.dart';


class EditProcess extends StatefulWidget {
  const EditProcess({super.key, required this.process});
  final AppProcess process;

  @override
  State<StatefulWidget> createState() => _EditProcess();
}

class _EditProcess extends State<EditProcess> {
  Future<List<DropdownMenuItem<String>>> folders = DropdownWidget.getDropDownWidgets();
  String dropdownValue = "";
  AppFolder folder = AppFolder(id:'', name:'', description:'');

  @override
  void initState() {
    super.initState();
    widget.process.getFolder().then((value) => folder = value);
    if(folder.id == '') {
      folder.name = 'No folder found';
    }
  }

  void reloadData() {
    setState(() {
      folders = DropdownWidget.getDropDownWidgets();
    });
  }

  @override
  Widget build(BuildContext context) {
    late String name, description;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void leavePage() {
      Navigator.pop(context);
    }

    Future<void> editProcess() async {
      FormState? formState = formKey.currentState!;
      if(formState.validate()) {
        formState.save();
        await RemoteDatabase.getUserData().collection('ListProcess').doc(widget.process.id).update({
          "name": name,
          "description": description,
          "folderID": dropdownValue
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
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text('Edit Process', style: TextStyle(color: Colors.white, fontSize: 36)),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type the name of your new process';
                      } else if(value.length > 200) {
                        return 'The name is too long. 200 characters max';
                      }
                      return null;
                    },
                    initialValue: widget.process.name,
                    onSaved: (value) => name = value!,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => description = value!,
                    initialValue: widget.process.description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    ),
                  ),
                  FutureBuilder<List<DropdownMenuItem<String>>>(
                    future: folders,
                    initialData: [DropdownWidget(id: folder.id, name: folder.name).getWidget()],
                    builder: (context, snapshot) {
                      List<DropdownMenuItem<String>> children;
                      if(snapshot.hasData) {
                        children = snapshot.data!;
                        if(children.isEmpty) {
                          children = [DropdownWidget(id: '', name: 'No folder found').getWidget()];
                        }
                      } else if (snapshot.hasError) {
                        children = [
                          DropdownWidget(id: '', name: 'Result : ${snapshot.error}').getWidget()
                        ];
                      } else {
                        children = [
                          DropdownWidget(id: '', name: 'Awaiting result...').getWidget()
                        ];
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Center(
                          child: DropdownButtonFormField(
                            style: const TextStyle(color: Color(0xFFAAAAAA)),
                            menuMaxHeight: 200,
                            value: dropdownValue,
                            items: children,
                            onChanged: (String? value) {
                              dropdownValue = value!;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          await editProcess();
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
  }
}
