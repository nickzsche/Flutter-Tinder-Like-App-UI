import 'package:flutter/material.dart';

class MessageDetailScreen extends StatelessWidget {
  final String userName;
  const MessageDetailScreen({Key? key, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messages = [
      {'sender': userName, 'text': 'Merhaba!'},
      {'sender': 'Ben', 'text': 'Selam! Nasılsın?'},
      {'sender': userName, 'text': 'İyiyim, teşekkürler. Sen?'},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true, // AppBar'ı saydam yapmak için ekleyin
      appBar: AppBar(
        title: Text(
          userName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF416C),
              Color(0xFFFF4B2B),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final isMe = messages[i]['sender'] == 'Ben';
                    return Container(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.pinkAccent.withOpacity(0.2)
                              : Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(messages[i]['text']!),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Mesaj yaz...',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
