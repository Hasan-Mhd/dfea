import 'package:dfea2/admin_screen.dart';
import 'package:dfea2/component/donation_form.dart';
import 'package:dfea2/donation_list_screen.dart';
import 'package:dfea2/donation_screen.dart';
import 'package:dfea2/home_page.dart';
import 'package:dfea2/signup_screen.dart';
import 'package:dfea2/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomePage.id: (context) => HomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        DonationScreen.id: (context) => DonationScreen(),
        DonationForm.id: (context) => DonationForm(),
        AdminScreen.id: (context) => AdminScreen(),
        DonationMainScreen.id: (context) => DonationMainScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
