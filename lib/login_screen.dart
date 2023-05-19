import 'package:dfea2/component/rounded_button.dart';
import 'package:dfea2/component/text_field.dart';
import 'package:dfea2/donation_screen.dart';
import 'package:dfea2/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: InputField(
                  'Email',
                  Icons.mail,
                  TextInputType.emailAddress,
                  false,
                  (value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: InputField(
                  'Password',
                  Icons.password,
                  TextInputType.text,
                  true,
                  (value) {
                    password = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 90, right: 90, bottom: 30),
                child: RoundedButton(
                    colour: Color(0xFFfeb800),
                    title: 'Sign in',
                    onPressed: () async {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);
                        if (user == null) {
                        } else {
                          Navigator.pushNamed(context, DonationScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    textColour: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SocialLoginButton(
                      backgroundColor: Color(0xFFf3f2f1),
                      borderRadius: 50,
                      text: "",
                      height: 70,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () async {
                        await FirebaseServices().signInWithGoogle();
                        Navigator.pushNamed(context, DonationScreen.id);
                      }),
                  SocialLoginButton(
                      borderRadius: 50,
                      text: "",
                      height: 70,
                      buttonType: SocialLoginButtonType.facebook,
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
