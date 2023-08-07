import 'package:dfea2/profile_screen.dart';
import 'package:flutter/material.dart';
import '../admin_login_screen.dart';
import 'donation_form.dart';

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
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Welcome To DFEA',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_shared),
              title: const Text('Donation Form'),
              onTap: () {
                Navigator.pushNamed(context, DonationForm.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('Admin'),
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
