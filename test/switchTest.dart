import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false; // ✅ Default: Light Mode

  void toggleThemeMode(bool value) {
    setState(() {
      isDarkTheme = value; // ✅ Theme har toggle par update hogi
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: TestScreen(
        isDarkTheme: isDarkTheme,
        toggleThemeMode: toggleThemeMode,
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> toggleThemeMode;

  const TestScreen({super.key, required this.isDarkTheme, required this.toggleThemeMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Test"),
        actions: [
          Switch(
            value: isDarkTheme,
            onChanged: (value) {
              toggleThemeMode(value); // ✅ Theme toggle karega
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Theme Test Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
