import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : snapshot.hasError
              ? const Center(child: Text('Something went wrong...'))
              : (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                  ? const Center(child: Text('Nothing here...'))
                  : ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(
                        bottom: 14,
                        left: 16,
                        right: 16,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        final currentMessage =
                            snapshot.data!.docs[index].data();
                        final isMe =
                            currentMessage['userId'] == authenticatedUser.uid;

                        if (index + 1 < snapshot.data!.docs.length) {
                          final nextMessage =
                              snapshot.data!.docs[index + 1].data();

                          if (currentMessage['userId'] ==
                              nextMessage['userId']) {
                            return MessageBubble.next(
                              message: currentMessage['text'],
                              isMe: isMe,
                            );
                          }
                        }

                        return MessageBubble.first(
                          userImage: currentMessage['userImage'],
                          username: currentMessage['username'],
                          message: currentMessage['text'],
                          isMe: isMe,
                        );
                      },
                    ),
    );
  }
}
