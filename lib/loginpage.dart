import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:week_3/splash_homescreen.dart';

class LoginPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    final String url = "https://reqres.in/api/login"; // ✅ Email-based API
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _emailController.text,
        "password": _passwordController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      // ✅ Success: Navigate to Home Splash Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeSplashScreen(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    } else {
      // ❌ Error: Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email or password"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Icon inside Stack
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.11,
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 15),

                  Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 20),

                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: login,
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
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                          ),
                          Text("Remember Me"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
