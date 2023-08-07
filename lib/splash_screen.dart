//
// import 'package:flutter/material.dart';
//
// class SplashScreen extends StatefulWidget {
//   static const String id = 'Splash_screen';
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2), // Duration of the animation
//     );
//
//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_animationController);
//
//     _animationController.forward();
//
//     // After the animation ends, navigate to the home screen
//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Navigator.pushReplacementNamed(context, 'Welcome_Screen');
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Customize the background color
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (BuildContext context, Widget? child) {
//             return Opacity(
//               opacity: _animation.value,
//               child: Transform.scale(
//                 scale: _animation.value,
//                 child: child,
//               ),
//             );
//           },
//           child: Text(
//             'Donation For Education App',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFFfeb800), // Customize the text color
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash_screen';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();

    // After the animation ends, navigate to the home screen
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, 'Welcome_Screen');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color(0xFFfeb800), // Yellow
                  Colors.white,
                ],
                stops: [
                  _animation.value,
                  _animation.value,
                ],
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: _animation.value,
                child: Transform.scale(
                  scale: _animation.value,
                  child: child,
                ),
              ),
            ),
          );
        },
        child: const Text(
          'Donation For Education App',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Customize the text color
          ),
        ),
      ),
    );
  }
}
