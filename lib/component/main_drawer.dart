import 'package:dfea2/admin_screen.dart';
import 'package:dfea2/profile_screen.dart';
import 'package:flutter/material.dart';
import '../admin_login_screen.dart';
import 'donation_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    super.key,
  });

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Hello Hasan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_shared),
              title: Text('Donation Form'),
              onTap: () {
                Navigator.pushNamed(context, DonationForm.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text('Admin'),
              onTap: () {
                Navigator.pushNamed(context, AdminLoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
