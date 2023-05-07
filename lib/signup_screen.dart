import 'package:dfea2/component/rounded_button.dart';
import 'package:dfea2/component/text_field.dart';
import 'package:dfea2/donation_screen.dart';
import 'package:dfea2/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(
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
                        fillColor: Color(0xFFf3f2f1),
                        icon: Icon(
                          Icons.account_box_outlined,
                          color: Color(0xFFfeb800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Full Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
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
                        fillColor: Color(0xFFf3f2f1),
                        icon: Icon(
                          Icons.email,
                          color: Color(0xFFfeb800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
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
                        fillColor: Color(0xFFf3f2f1),
                        icon: Icon(
                          Icons.password,
                          color: Color(0xFFfeb800),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
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
                        colour: Color(0xFFfeb800),
                        title: 'Sign up',
                        onPressed: () async {
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email!, password: password!);
                            if (newUser == null) {
                              Toast.show("Enter Email",
                                  backgroundColor: Colors.amber,
                                  duration: Toast.lengthShort,
                                  gravity: Toast.bottom);
                            } else {
                              Navigator.pushNamed(context, DonationScreen.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        Text(
                          'Have an Account?',
                          style: TextStyle(color: Colors.black38),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () async {
                            setState(() {
                              showSpinner = true;
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
