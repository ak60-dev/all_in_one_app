import 'package:flutter/material.dart';
import 'package:week_3/splash_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isDarkMode = false ; //Light theme by default

  @override

  Widget build(BuildContext context){
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = !isDarkMode ;
          });
        }
      ),

    );
  }
}

/*class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
  itemCount: 200, // Creates 5 cards
  itemBuilder: (context, index) {
    return Card(
      elevation: 4, // Adds shadow
      margin: EdgeInsets.all(10), // Adds space around the card
      child: ListTile(
        leading: Icon(Icons.person), // Left-side icon
        title: Text("User ${index + 1}"), // Dynamic title
        subtitle: Text("user${index + 1}@email.com"), // Dynamic email
        trailing: Icon(Icons.arrow_forward), // Right-side icon
      ),
    );
  },
)

    );
  }
}

/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Default is Light Mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Apply theme
      home: Scaffold(
        appBar: AppBar(title: Text("Theme Switcher")),
        body: Center(
          child: Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value; // Change theme when switch is toggled
              });
            },
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

void main() {
  runApp(AnimationDemo());
}

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  bool isVisible = true;
  bool isExpanded = false;
  bool isMoved = false;
  bool isCrossFade = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Animations Demo")),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ 1. Smooth Fade In/Out
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: isVisible ? 1.0 : 0.0,
                  child: Text("Fade Me!", style: TextStyle(fontSize: 24)),
                ),
                SizedBox(height: 20),

                // ✅ 2. Animate Padding
                AnimatedPadding(
                  duration: Duration(seconds: 1),
                  padding: EdgeInsets.all(isExpanded ? 50 : 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded; // Toggle padding
                      });
                    },
                    child: Text("Animated Padding"),
                  ),
                ),
                SizedBox(height: 20),

                // ✅ 3. Crossfade Between Two Widgets
                AnimatedCrossFade(
                  duration: Duration(seconds: 1),
                  firstChild: Icon(Icons.light_mode, size: 50, color: Colors.orange),
                  secondChild: Icon(Icons.dark_mode, size: 50, color: Colors.black),
                  crossFadeState: isCrossFade
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
                SizedBox(height: 20),

                // Toggle Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible; // Toggle fade
                        });
                      },
                      child: Text("Toggle Fade"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCrossFade = !isCrossFade; // Toggle crossfade
                        });
                      },
                      child: Text("Toggle Crossfade"),
                    ),
                  ],
                ),
              ],
            ),

            // ✅ 4. Move Widget in Stack
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              left: isMoved ? 200 : 50,
              top: 100,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMoved = !isMoved; // Toggle position
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/*/*/