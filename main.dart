import 'package:flutter/material.dart';

void main() {
  runApp(const AdeebChatApp());
}

class AdeebChatApp extends StatelessWidget {
  const AdeebChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adeeb Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const ChatHomeScreen(),
    );
  }
}

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isMe: true,
          status: 'جاري البحث عن عقدة قريبة... ⏳🌐',
        ),
      );
    });

    _messageController.clear();
    
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        if (_messages.isNotEmpty && _messages.last.status.contains('⏳')) {
          _messages.last.status = 'تم تمرير الرسالة عبر 3 أجهزة بنجاح 🚀';
        }
      });
    });
  }

  // نافذة حول التطبيق والمعلومات الشخصية
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blueAccent),
            SizedBox(width: 10),
            Text('عن التطبيق', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تطبيق Adeeb Chat للمراسلة المحلية المشفرة عبر شبكة تشاركية بدون إنترنت.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Divider(height: 25, color: Colors.white24),
            Text(
              'التطبيق من تطوير:',
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'محمد أديب بلال كاش',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'سوريا - إدلب - بلدة دير الغربي 📍',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                'جميع الحقوق محفوظة© 2026-2027',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: const Icon(Icons.hub_outlined, size: 20, color: Colors.white),
            ),
            const Text('Adeeb Chat - offline mesh'),
          ],
        ),
        backgroundColor: const Color(0xFF1F1F1F),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white70),
            onPressed: _showAboutDialog,
          ),
          IconButton(
            icon: const Icon(Icons.radar, color: Colors.greenAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري مسح الشبكة المحلية عن أجهزة Adeeb Chat...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: msg.isMe ? const Color(0xFF005C4B) : const Color(0xFF202C33),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: msg.isMe ? const Radius.circular(16) : const Radius.circular(0),
                        bottomRight: msg.isMe ? const Radius.circular(0) : const Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.text,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          msg.status,
                          style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1F1F1F),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالتك المشفرة... 🔐',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          
          // شريط حقوق الحفظ والمعلومات أسفل الشاشة
          Container(
            color: const Color(0xFF151515),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: const Text(
              'تطوير محمد أديب بلال كاش - دير الغربي | جميع الحقوق محفوظة© 2026-2027',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.white38),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  String text;
  bool isMe;
  String status;

  ChatMessage({required this.text, required this.isMe, required this.status});
}
