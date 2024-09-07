import 'package:flutter/material.dart';
import 'package:guardian_eye/data/faq_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _handleSubmitted(String query) {
    // Find FAQ by keywords instead of full question
    List<String> keywords = query.toLowerCase().split(' '); // Split query into keywords
    String? response;

    for (var faq in faqData) {
      // Check if any of the keywords match part of the question
      if (keywords.any((keyword) => faq["question"]!.toLowerCase().contains(keyword))) {
        response = faq["answer"];
        break;
      }
    }

    // If no match is found, provide a default response
    response ??= "Sorry, I don't have an answer for that. Please try asking differently.";

    setState(() {
      _messages.add({"user": query});
      _messages.add({"bot": response!});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: <Widget>[
          // Clickable sample question at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _handleSubmitted("What is GuardianEye?");
              },
              child: const Text(
                'Try asking: "What is GuardianEye?"',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Make it look clickable
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.containsKey("user") ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.containsKey("user") ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message.containsKey("user") ? message["user"]! : message["bot"]!,
                        style: TextStyle(color: message.containsKey("user") ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
