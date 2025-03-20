import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // ✅ Expression evaluation ke liye

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorScreen(),
  ));
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = ""; // ✅ User input store karega
  String result = "0"; // ✅ Calculation ka result store karega

  // ✅ List of buttons for the calculator
  final List<String> buttons = [
    "7", "8", "9", "/",
    "4", "5", "6", "*",
    "1", "2", "3", "-",
    "C", "0", "=", "+"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          // ✅ Display Screen
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                input.isEmpty ? result : input,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // ✅ Buttons Grid
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // ✅ 4 columns for buttons
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _onButtonPressed(buttons[index]);
                    });
                  },
                  child: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        buttons[index],
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Button Click Logic
  void _onButtonPressed(String value) {
    if (value == "C") {
      input = "";
      result = "0";
    } else if (value == "=") {
      try {
        Parser p = Parser();
        Expression exp = p.parse(input);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        result = eval.toString();
      } catch (e) {
        result = "Error";
      }
      input = "";
    } else {
      input += value;
    }
  }
}
