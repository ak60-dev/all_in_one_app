import 'package:flutter/material.dart';

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
}
