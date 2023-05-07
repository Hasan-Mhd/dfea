import 'package:dfea2/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'component/rounded_button.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFfeb800),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Donation For Education',
                          speed: Duration(milliseconds: 150))
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                  textColour: Color(0xFFfeb800),
                  colour: Colors.white,
                  title: 'Sign up',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  }),
              RoundedButton(
                  textColour: Color(0xFFfeb800),
                  colour: Colors.white,
                  title: 'Sign in',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
