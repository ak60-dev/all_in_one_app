import 'package:flutter/material.dart';
import 'package:week_3/splash_homescreen.dart';

class LoginPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: onThemeChanged, // Calls function to update theme in main.dart
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Icon inside Stack
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.blue, // Background color for profile section
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.11,
                left: MediaQuery.of(context).size.width / 2 - 40, // Centers icon
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
              ),
            ],
          ),

          // Login Section
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50), // Space for profile icon
                Text(
                  "Login",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(height: 20),
ElevatedButton(
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeSplashScreen(isDarkMode: isDarkMode, onThemeChanged: onThemeChanged, // 🔥 Home Splash Screen pe jaayega pehle
      ),));
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    minimumSize: Size(double.infinity, 50),
  ),
  child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
