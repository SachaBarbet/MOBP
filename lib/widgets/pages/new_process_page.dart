import 'package:flutter/material.dart';
import 'package:mobp/models/database_table.dart';
import 'package:mobp/models/tables/procedure.dart';
import 'package:mobp/widgets/text_form_field_custom.dart';
import 'package:sqflite/sqflite.dart';

import '../../app.locator.dart';
import '../../services/local_storage_service.dart';

class NewProcessPage extends StatefulWidget {
  const NewProcessPage({super.key});

  @override
  State<NewProcessPage> createState() => _NewProcessPage();
}

class _NewProcessPage extends State<NewProcessPage> {

  final _formKey = GlobalKey<FormState>();
  final localStorageService = locator<LocalStorageService>();
  String _name = '';
  String _description = '';
  String _software = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF3C3C42),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormFieldCustom('Procedure Name', (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please give a name to your procedure';
                  } else {
                    _name = value;
                  }
                  return null;
                }, maxCharacters: 48),
                TextFormFieldCustom('opt: Description', (value) {
                  if (value != null && value.isNotEmpty) {
                    _description = value;
                  }
                  return null;
                }),
                TextFormFieldCustom('opt: Software', (value) {
                  if (value != null && value.isNotEmpty) {
                    _software = value;
                  }
                  return null;
                }, maxCharacters: 32),
                Padding(padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),
                    child: const Text('ADD'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Database db = await localStorageService.initLocalDatabase();
                        List<DatabaseTable> valuesList = await localStorageService.values(db, 'procedures');
                        int newID = valuesList.length;
                        Procedure procedure = Procedure(id: newID, name: _name, description: _description, software: _software);
                        localStorageService.insert(db, procedure);
                        db.close();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}