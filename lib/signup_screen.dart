import 'package:dfea2/component/rounded_button.dart';
import 'package:dfea2/donation_screen.dart';
import 'package:dfea2/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'SignupScreen';

  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? name;
  String? email;
  String? password;

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFFfeb800)),
              ),
            ),
          ],
        );
      },
    );
  }

  bool validateFields() {
    if (name == null || name!.isEmpty) {
      showErrorDialog("Please enter your full name");
      return false;
    }
    if (email == null || email!.isEmpty) {
      showErrorDialog("Please enter your email");
      return false;
    }
    if (password == null || password!.isEmpty) {
      showErrorDialog("Please enter your password");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 32),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFf3f2f1),
                        icon: const Icon(
                          Icons.account_box_outlined,
                          color: Color(0xFFfeb800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Full Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFfeb800),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFf3f2f1),
                        icon: const Icon(
                          Icons.email,
                          color: Color(0xFFfeb800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFfeb800),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFf3f2f1),
                        icon: const Icon(
                          Icons.password,
                          color: Color(0xFFfeb800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFfeb800),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 90, right: 90, top: 50),
                    child: RoundedButton(
                      textColour: Colors.white,
                      colour: const Color(0xFFfeb800),
                      title: 'Sign up',
                      onPressed: () async {
                        if (validateFields()) {
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            );
                            if (newUser == null) {
                              Toast.show(
                                "Enter Email",
                                backgroundColor: Colors.amber,
                                duration: Toast.lengthShort,
                                gravity: Toast.bottom,
                              );
                            } else {
                              Navigator.pushNamed(context, DonationScreen.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        const Text(
                          'Have an Account?',
                          style: TextStyle(color: Colors.black38),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () async {
                            setState(() {
                              Navigator.pushNamed(context, LoginScreen.id);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
