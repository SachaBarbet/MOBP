import 'package:flutter/material.dart';
import 'package:mobp/utilities/authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  late String email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    void leaveLoginPage() {
      Navigator.pop(context);
    }

    Future<void> signIn() async {
      FormState? formState = formKey.currentState!;
      if(formState.validate()) {
        formState.save();
        await UserAuthentication.signIn(email, password);
        leaveLoginPage();
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xFF3D3B3C),
      body: Center(
        child: Form(
          key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type an email';
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type a password';
                      } else if (value.length < 6) {
                        return 'Password too short !';
                      }
                      return null;
                    },
                    onSaved: (value) => password = value!,
                    decoration: const InputDecoration(
                      labelText: 'password',
                    ),
                    obscureText: true,
                  ),
                  TextButton(
                      onPressed: () async {
                        await signIn();
                      },
                      child: const Text('Sign In'))
                ],
              ),
            ),
        ),
      ),
    );
  }
  
}