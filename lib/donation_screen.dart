import 'package:dfea2/donation_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'component/main_drawer.dart';

class DonationScreen extends StatefulWidget {
  static const String id = 'DonationScreen';
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();

    // TODO: implement dispose
    super.dispose();
  }

  // final GlobalKey<ScaffoldState> _sKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          title: const Text(
            'Donations',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: const DonationMainScreen(),
      ),
    );
  }
}
