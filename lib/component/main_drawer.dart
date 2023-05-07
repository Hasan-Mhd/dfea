import 'package:dfea2/admin_screen.dart';
import 'package:flutter/material.dart';

import 'donation_form.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Hello Hasan'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text('Admin'),
              onTap: () {
                Navigator.pushNamed(context, AdminScreen.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Donation Form'),
              onTap: () {
                Navigator.pushNamed(context, DonationForm.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
