import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool _isSending = false;
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }

  void _sendMessage() async {
    final trimedText = _messageController.text.trim();

    if (trimedText.length < 2) {
      _showMessage('Length of message must be equal or higer than 2');
      return;
    }

    _messageController.clear();
    FocusScope.of(context).unfocus();
    setState(() => _isSending = true);

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    await FirebaseFirestore.instance.collection('chat').add({
      'text': trimedText,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });

    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 5, 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLength: 100,
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              decoration: const InputDecoration(labelText: 'Text'),
            ),
          ),
          IconButton(
            onPressed: _isSending ? null : _sendMessage,
            icon: _isSending
                ? const CircularProgressIndicator()
                : Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
        ],
      ),
    );
  }
}
