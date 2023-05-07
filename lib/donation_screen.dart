import 'package:dfea2/component/donation_form.dart';
import 'package:dfea2/donation_list_screen.dart';
import 'package:flutter/material.dart';
import 'component/main_drawer.dart';

class DonationScreen extends StatefulWidget {
  static const String id = 'DonationScreen';
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  // final GlobalKey<ScaffoldState> _sKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: DonationMainScreen(),
      ),
    );
  }
}
