import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget{
   UserListScreen({super.key});

  final List<Map<String, String>> users = [
    {"name": "Robot1","subtitle":"Terminate everyone " , "work" : "Terminator","image":"assets/R1.png"},
    {"name": "Robot2","subtitle":"cooking every dishes " , "work" : "cheif","image":"assets/R2.png"},
    {"name": "Robot3","subtitle":"cleaning every area " , "work" : "Cleaner","image":"assets/R3.png"},
    {"name": "Robot4","subtitle":"Protecting every places " , "work" : "Guards","image":"assets/R4.png"}

  ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("User List",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue),

      body: ListView.builder(itemCount: users.length ,itemBuilder: (context, index){
        return Card(child: ListTile(leading: CircleAvatar(backgroundImage: AssetImage(users[index]["image"]!),),
        title: Text(users[index]["name"]!),
        subtitle: Text(users[index]["subtitle"]!),
        trailing: Text(users[index]["work"]!),
        ),
        );
      },
      ),
    );
  }
}

