import 'package:flutter/material.dart';
import 'package:mobp/utilities/remote_database.dart';


class AddImageComponent extends StatefulWidget {
  final String processID;
  final int index;
  const AddImageComponent({super.key, required this.processID, required this.index});

  @override
  State<StatefulWidget> createState() => _AddImageComponent();
}

class _AddImageComponent extends State<AddImageComponent> {

  Future<void> addImage(String url) async {
    await RemoteDatabase.getUserData().collection('ListProcess')
        .doc(widget.processID).collection('Components')
        .add({'componentIndex': widget.index, 'componentWidget': 'image', 'data': [url]});
  }

  @override
  Widget build(BuildContext context) {
    late String url;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void leavePage() {
      Navigator.pop(context);
    }

    Future<void> confirmForm() async {
      FormState? formState = formKey.currentState!;
      if(formState.validate()) {
        formState.save();
        await addImage(url);
        leavePage();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF262525),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFEAC435),
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
                    child: Text('Add Image', style: TextStyle(color: Colors.white, fontSize: 32)),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => url = value!,
                    decoration: const InputDecoration(
                      labelText: 'Url',
                      labelStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          await confirmForm();
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
