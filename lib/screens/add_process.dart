import 'package:flutter/material.dart';
import 'package:mobp/utilities/remote_database.dart';
import 'package:mobp/widgets/dropdown_widget.dart';


class AddProcess extends StatefulWidget {
  const AddProcess({super.key});

  @override
  State<StatefulWidget> createState() => _AddProcess();
}

class _AddProcess extends State<AddProcess> {
  Future<List<DropdownMenuItem<String>>> folders = DropdownWidget.getDropDownWidgets();
  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
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

    Future<void> addProcess() async {
      FormState? formState = formKey.currentState!;
      if(formState.validate()) {
        formState.save();
        await RemoteDatabase.getUserData().collection('ListProcess').add({
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
                    child: Text('New Process', style: TextStyle(color: Colors.white, fontSize: 36)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type the name of your new process';
                      } else if(value.length > 200) {
                        return 'The name is too long. 200 characters max';
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
                  ),
                  FutureBuilder<List<DropdownMenuItem<String>>>(
                    future: folders,
                    initialData: [DropdownWidget(id: '', name: 'No folder found').getWidget()],
                    builder: (context, snapshot) {
                      List<DropdownMenuItem<String>> children;
                      if(snapshot.hasData) {
                        children = snapshot.data!;
                      } else if (snapshot.hasError) {
                        children = [
                          DropdownWidget(id: '', name: 'Result : ${snapshot.error}').getWidget()
                        ];
                      } else {
                        children = [
                          DropdownWidget(id: '', name: 'Awaiting result...').getWidget()
                        ];
                      }
                      return Center(
                        child: DropdownButtonFormField(
                          value: dropdownValue,
                          items: children,
                          onChanged: (String? value) {
                            dropdownValue = value!;
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          await addProcess();
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
  }
}
