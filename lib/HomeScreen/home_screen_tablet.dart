import 'package:flutter/material.dart';
import 'package:week_3/calculator_screen.dart';
import 'package:week_3/kids_learning_screen.dart';
import 'package:week_3/temperature_converter_screen.dart';
import 'package:week_3/user_list_screen.dart';

class HomeScreenTablet extends StatelessWidget {
  final List<Map<String, dynamic>> apps = [
    {"name": "User List", "icon": Icons.people, "screen": UserListScreen()},
    {"name": "Temperature Converter", "icon": Icons.thermostat, "screen": TemperatureConverterApp()},
    {"name": "Kids Learning App","icon":Icons.school, "screen": KidsLearningScreen()},
    {"name": "Calculator" , "icon":Icons.calculate, "screen": CalculatorScreen()}
  ];

   HomeScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tablet Home Screen", style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: apps.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => apps[index]['screen']));
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(apps[index]["icon"], size: 50),
                    Text(apps[index]["name"], style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
