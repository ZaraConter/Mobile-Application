import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:giphy_get/giphy_get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];
  bool _showEmojiPicker = false;

  void _sendMessage({String? text, String? gifUrl}) {
    if (text != null && text.isNotEmpty) {
      setState(() {
        messages.add({'type': 'text', 'content': text});
        _controller.clear();
      });
    } else if (gifUrl != null) {
      setState(() {
        messages.add({'type': 'gif', 'content': gifUrl});
      });
    }

    // Auto-scroll to the latest message
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Dismiss keyboard and emoji picker after sending a message
    FocusScope.of(context).unfocus();
    setState(() {
      _showEmojiPicker = false;
    });
  }

  void _pickGif() async {
    GiphyGif? gif = await GiphyGet.getGif(
      context: context,
      apiKey: 'YOUR_GIPHY_API_KEY', // Replace with your Giphy API key
      lang: GiphyLanguage.english,
    );

    if (gif != null) {
      _sendMessage(gifUrl: gif.images!.original!.url);
    }
  }

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
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: message['type'] == 'text'
                        ? Text(
                            message['content'],
                            style: const TextStyle(color: Colors.white),
                          )
                        : Image.network(message['content']),
                  ),
                );
              },
            ),
          ),
          if (_showEmojiPicker)
            SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _controller.text += emoji.emoji;
                },
              ),
            ),
          // Input field, emoji, and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  onPressed: () {
                    setState(() {
                      _showEmojiPicker = !_showEmojiPicker;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.gif),
                  onPressed: _pickGif,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _sendMessage(text: value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(text: _controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
