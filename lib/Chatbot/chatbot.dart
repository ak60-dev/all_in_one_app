import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:week_3/Chatbot/api_gemini_key.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> _messages = [];
  late Gemini _gemini;
  bool _isLoading = false;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _gemini = Gemini.init(apiKey: apiKey);
    _addBotMessage("Hey there! 😊 I'm Owais Ahmed from support. How can I assist you today?");
  }

  void _sendMessage(String query) async {
    if (query.isEmpty) return;
    setState(() {
      _messages.add({"user": query});
    });

    _controller.clear();
    FocusScope.of(context).unfocus();
    String result = '';

    await Future.delayed(Duration(seconds: 1)); // Quick response
    setState(() => _isTyping = true);

    try {
      await for (var value in _gemini.promptStream(parts: [
        Part.text("You are Owais Ahmed, the support assistant for our app. Provide detailed answers to app-related queries, including features, troubleshooting, and improvements. If it's unrelated, try to guide the user or politely indicate that the query is outside of support scope. User: $query AI:")
      ])) {
        result += value?.output ?? '';
      }
    } catch (e) {
      result = "Oops! Something went wrong. Can you try again?";
    }

    if (query.toLowerCase().contains("feature") || query.toLowerCase().contains("suggest")) {
      result = "Great idea! I'll pass it to the development team. Could you provide more details?";
    } else if (query.toLowerCase().contains("who are you")) {
      result = "I'm Owais from the support team. How can I assist you today? 😊";
    } else if (query.toLowerCase().contains("hell") || query.toLowerCase().contains("stupid") || query.toLowerCase().contains("worst")) {
      result = "I’m sorry if my response wasn’t helpful. I’m here to assist with app-related queries. Let's keep it positive! 😊";
    } else if (query.toLowerCase().contains("add app")) {
      result = "Our app allows multiple apps within it. If you'd like to add another app, please specify what type of app you are referring to!";
    } else if (query.toLowerCase().contains("search") || query.toLowerCase().contains("find")) {
      result = "I recommend using Google or relevant online resources to search for that information.";
    }

    setState(() {
      _messages.add({"bot": result});
      _isTyping = false;
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _addBotMessage(String message) {
    setState(() {
      _messages.add({"bot": message});
    });
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.support_agent),
            SizedBox(width: 10),
            Text('Support'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Typing...", style: TextStyle(color: Colors.black)),
                    ),
                  );
                }

                final message = _messages[index];
                final isUser = message.containsKey("user");
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.values.first,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text.trim()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
