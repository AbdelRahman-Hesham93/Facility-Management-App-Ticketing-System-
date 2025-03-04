import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/globalvar.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChatPage();
  }
}

class ChatPage extends StatefulWidget {
  ChatPage({Key? key});
  final AuthCode _authCode = AuthCode();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Each message has 'senderId', 'message', and 'photoUrl'
  io.Socket? socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    // Replace 'http://your_server_address' with your actual server address
    socket = io.io(url, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket!.on('connect', (_) {
      print('Connected to server');
    });

    socket!.on('chat message', (data) {
      setState(() {
        _messages.add(data);
      });
    });

    socket!.connect();
  }

  void sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      socket!.emit('chat message', {
        'senderId': widget._authCode.user?.uid ?? '',
        'message': message,
        'photoUrl': widget._authCode.user?.photoURL,
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    socket!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = widget._authCode.user;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      appBar: AppBar(
        title: const Text('Facility Chat'), centerTitle: true
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageRow(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color.fromRGBO(76, 143, 78, 1,)),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageRow(int index) {
    final message = _messages[index];
    final isCurrentUser = message['senderId'] == widget._authCode.user?.uid;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isCurrentUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        // User photo (you can replace the placeholder with your actual user photo)
        CircleAvatar(
          backgroundImage: NetworkImage(message['photoUrl'] ?? ''),
        ),
        const SizedBox(width: 8), // Add some spacing between photo and message box
        // Message box
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.white : const Color.fromARGB(255, 235, 232, 232),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message['message'],
            style: TextStyle(
              fontSize: 20,
              color: isCurrentUser ? Colors.black : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
