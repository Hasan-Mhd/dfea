import 'package:dfea2/donation_screen.dart';
import 'package:dfea2/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleLoginScreen extends StatefulWidget {
  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  late GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn();
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Successful Google sign-in
        // You can now use the `googleUser` object to access user details
        // and perform further actions like storing user data in Firestore.

        // Example: Get user details
        String userId = googleUser.id;
        String userEmail = googleUser.email;
        String userName = googleUser.displayName ?? '';

        // Sign in or create user using Google credentials
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Store user data in Firestore
          final userRef = _firestore.collection('users').doc(user.uid);
          await userRef.set({
            'email': user.email,
            'displayName': user.displayName,
          });
        }

        print('Google Sign-In Successful');
        Navigator.pushNamed(context, DonationScreen.id);
      } else {
        // Google sign-in canceled by user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-In Canceled'),
          ),
        );
      }
    } catch (error) {
      // Error occurred during Google sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfeb800),
        title: Text('Google Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign in with Google',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFfeb800))),
              onPressed: _handleGoogleSignIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
