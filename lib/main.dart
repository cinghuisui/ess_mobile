import 'package:flutter/material.dart';
import 'package:ess_mobile/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_ess/model/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define the animation (fade-in effect)
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    // Start the animation
    _animationController.forward();

    // Navigate to the home page after a delay
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
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
      // backgroundColor: const Color.fromARGB(255, 21, 104, 171), // Background color of the splash screen
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/coconutoil.webp"), // Gambar dari folder assets
          //   fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi layar
          // ),
          gradient: LinearGradient(
            colors: [
              // Color.fromARGB(255, 16, 76, 204),
              // Color.fromARGB(244, 9, 174, 234),
              // Color.fromARGB(175, 158, 158, 158),
              // Color.fromARGB(92, 33, 149, 243),
              Color.fromARGB(255, 8, 133, 236),
              Color.fromARGB(255, 6, 59, 151),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/essadm.png',
                  width: 300,
                ),
                // Image.asset(
                //       "assets/essadm.png",
                //       width: 300,
                //       // height: 300,
                //     ),
                const SizedBox(height: 20),
                Text(
                  'WELCOME TO ESS',
                  style: GoogleFonts.amiriQuran(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    // color: Colors.white
                  ),
                  // style: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 24,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: const Center(
//         child: Text('This is the Home Page'),
//       ),
//     );
//   }
// }
