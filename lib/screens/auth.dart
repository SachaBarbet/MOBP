import 'package:flutter/material.dart';
import 'package:mobp/screens/signin.dart';
import 'package:mobp/screens/signup.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 230, top: 120),
              child: Text('Authentication', style: TextStyle(color: Colors.white, fontSize: 36),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20, color: Colors.white), backgroundColor: const Color(0xFFEAC435), fixedSize: const Size(266, 40)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SignIn()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                  child: Text('Sign In'),)
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20, color: Colors.white), backgroundColor: const Color(0xFFEAC435), fixedSize: const Size(266, 40)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const SignUp()));
              },
              child: const Text('Sign Up')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Continue offline', style: TextStyle(color: Color(0xFFEAC435), fontSize: 18),)
              ),
            )
          ],
        ),
      ),
    );
  }
}
