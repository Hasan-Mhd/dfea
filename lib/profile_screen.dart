import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfea2/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  String _userName = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Retrieve the user data from the donations collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('donations')
          .where('userId', isEqualTo: _user.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Access the first document in the query snapshot
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
        // Retrieve the 'name' and 'phone' fields from the document
        String userName = documentSnapshot.get('name');
        String phoneNumber = documentSnapshot.get('phone');
        // Update the user's data
        setState(() {
          _userName = userName;
          _phoneNumber = phoneNumber;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if a user is authenticated
    // ignore: unnecessary_null_comparison
    if (_user == null) {
      // Navigate to the login screen or any other desired screen
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
      return Container(); // Return an empty container temporarily
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfeb800),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $_userName',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${_user.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone Number: $_phoneNumber',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransactionHistoryScreen()));
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFfeb800)),
                ),
                child: const Text('Transactions histore'))
          ],
        ),
      ),
    );
  }
}
