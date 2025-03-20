import 'package:flutter/material.dart';
import 'package:week_3/HomeScreen/home_screen_mobile.dart';
import 'package:week_3/HomeScreen/home_screen_pc.dart';
import 'package:week_3/HomeScreen/home_screen_tablet.dart';


class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool>onThemeChanged;
  const HomeScreen({super.key, required this.isDarkMode, required this.onThemeChanged});
  //const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return HomeScreenMobile(); // Show Mobile UI
    } else if (screenWidth < 1024) {
      return HomeScreenTablet(); // Show Tablet UI
    } else {
      return HomeScreenPC(); // Show PC UI
    }
  }
}










/*body: Padding(padding: EdgeInsets.all(16),
      child: GridView.count(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserListScreen()));
          },
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people,size: 50,color: Colors.blue),
                SizedBox(height: 10),
                Text("User Lsit",style: TextStyle(fontSize: 18))
              ],
            ),
          ),
        )
      ],
      ),
      ),*/