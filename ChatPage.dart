import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          // Chat messages display
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Text field for entering messages
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      if (_controller.text.isNotEmpty) {
                        messages.add(_controller.text);
                        _controller.clear(); // Clear the text field after sending
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
