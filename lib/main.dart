<<<<<<< HEAD
import 'package:dfea2/admin_screen.dart';
import 'package:dfea2/component/donation_form.dart';
import 'package:dfea2/donation_list_screen.dart';
import 'package:dfea2/donation_screen.dart';
import 'package:dfea2/home_page.dart';
import 'package:dfea2/signup_screen.dart';
import 'package:dfea2/splash_screen.dart';
import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
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
        SplashScreen.id: (context) => const SplashScreen(),
        HomePage.id: (context) => const HomePage(),
        AdminLoginScreen.id: (context) => const AdminLoginScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        DonationScreen.id: (context) => const DonationScreen(),
        DonationForm.id: (context) => const DonationForm(),
        AdminScreen.id: (context) => const AdminScreen(),
        DonationMainScreen.id: (context) => const DonationMainScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
=======
import 'package:flutter/material.dart';
import 'screens/input_page.dart';
import 'package:dynamic_island/dynamic_island.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xff090C22),
          ),
          scaffoldBackgroundColor: Color(0xff090C22),
        ),
        home: InputPage());
>>>>>>> 9f39253 (final)
  }
}
