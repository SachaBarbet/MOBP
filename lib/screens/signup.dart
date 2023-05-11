import 'package:flutter/material.dart';

import '../utilities/authentication.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    late String email, password, name;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void leaveRegisterPage() {
      Navigator.pop(context);
    }

    Future<void> signUp() async {
      FormState? formState = formKey.currentState!;
      if(formState.validate()) {
        formState.save();
        bool tryRegister = await UserAuthentication.signUp(email, password, name);
        if(tryRegister) leaveRegisterPage();
      }
    }

    return Scaffold(
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
                  child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 36)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type your name';
                    }
                    return null;
                  },
                  onSaved: (value) => name = value!,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () async {
                        await signUp();
                      },
                      child: const Text('Sign Up', style: TextStyle(color: Color(0xFFEAC435), fontSize: 20),)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}