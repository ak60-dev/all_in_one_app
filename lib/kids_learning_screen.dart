import 'package:flutter/material.dart';

class KidsLearningScreen extends StatefulWidget {
   const KidsLearningScreen({super.key});

  @override
  State<KidsLearningScreen> createState() => _KidsLearningScreenState();
}

class _KidsLearningScreenState extends State<KidsLearningScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "Type aletter (A-Z)";

  Map<String, String> letterObjects = {
    "A" : "Apple",
    "B": "Banana",
    "C": "Cat",
    "D": "Dog",
    "E": "Elephant",
    "F": "Fish",
    "G": "Grapes",
    "H": "Horse",
    "I": "Ink",
    "J": "Jame",
    "K": "Kite",
    "L": "Lime",
    "M": "Money",
    "N": "NetWorth",
    "O": "Orange",
    "P": "Power",
    "Q": "Querry",
    "R": "Rain",
    "S": "Strawberry",
    "T": "Banana",
    "U": "Umbrella",
    "V": "Van",
    "X": "Xtreme",
    "Y": "Year",
    "Z": "Zebra",
  };

  void _onTextChanged(String value){
    if(value.isNotEmpty){
      String letter = value.toUpperCase();
      setState(() {
        _result = letterObjects[letter]??"No match found";
      });
    }else{
      setState(() {
        _result="Type a letter (A-Z)";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, title:  Text('Kids Learning App',style: TextStyle(color: Colors.white),), centerTitle: true,
      ),
      body: Padding(padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            maxLength: 1,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            decoration: InputDecoration(
              hintText: "Enter a Letter",
              border: OutlineInputBorder(),
            ),
            onChanged: _onTextChanged,
          ),
          SizedBox(height: 20,),
          Text(
            _result,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
          )
        ],

      ),
      
      ),
      
    );
  }
}