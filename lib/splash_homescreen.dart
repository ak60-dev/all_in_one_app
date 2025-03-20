import 'package:flutter/material.dart';
import 'package:week_3/homescreen.dart';

class HomeSplashScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const HomeSplashScreen({super.key, required this.isDarkMode, required this.onThemeChanged});
  @override
  _HomeSplashScreenState createState() => _HomeSplashScreenState();
}

class _HomeSplashScreenState extends State<HomeSplashScreen> {
  bool isAnimating = false; // Magnet Effect ke liye state

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimating = true; // Animation start hote hi state update
      });
    });

    // 3 second baad Home Screen open karega
Future.delayed(Duration(seconds: 3), () {
  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          isDarkMode: widget.isDarkMode, // ✅ Ensure it's defined
          onThemeChanged: widget.onThemeChanged, // ✅ Ensure it's passed
        ),
      ),
    );
  }
});

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue, // Background color
      body: Stack(
        children: [
          // App Icons (Initially scattered, phir move karenge)
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            left: isAnimating ? screenWidth * 0.3 : 20,
            top: isAnimating ? screenHeight * 0.4 : 50,
            child: Icon(Icons.calculate, size: 50, color: Colors.white), // Example App 1
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            left: isAnimating ? screenWidth * 0.5 : screenWidth - 80,
            top: isAnimating ? screenHeight * 0.3 : 100,
            child: Icon(Icons.school, size: 50, color: Colors.white), // Example App 2
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            left: isAnimating ? screenWidth * 0.4 : 50,
            top: isAnimating ? screenHeight * 0.6 : screenHeight - 100,
            child: Icon(Icons.games, size: 50, color: Colors.white), // Example App 3
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            left: isAnimating ? screenWidth * 0.6 : screenWidth - 60,
            top: isAnimating ? screenHeight * 0.5 : screenHeight - 80,
            child: Icon(Icons.science, size: 50, color: Colors.white), // Example App 4
          ),

          // SmartHub Text (Jo Welcome se change hoga)
          Center(
            child: AnimatedCrossFade(
              duration: Duration(seconds: 2),
              firstChild: Text("Welcome",
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
              secondChild: Text("SmartHub",
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
              crossFadeState: isAnimating ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            ),
          ),
        ],
      ),
    );
  }
}
