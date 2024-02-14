import 'package:bql_test/utils/millisecs_to_readable_time.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.isMe, required this.message});

  final bool isMe;
  final BaseMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment
                .start, // Align the message to the right if it's from the current user.
        children: [
          // sender's avatar
          if (!isMe)
            CircleAvatar(
              backgroundColor: const Color(0xFF1A1A1A),
              backgroundImage: message.sender!.profileUrl.isNotEmpty
                  ? NetworkImage(message.sender!.profileUrl)
                  : null,
              child: message.sender!.profileUrl.isEmpty
                  ? Icon(Icons.person, color: Colors.grey.shade800)
                  : null,
            ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              gradient: isMe
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF006B), Color(0xFFFF4593)],
                    )
                  : null,
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(20),
                bottomRight: const Radius.circular(20),
                topRight: !isMe
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
                topLeft:
                    isMe ? const Radius.circular(20) : const Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    !isMe
                        ? SizedBox(
                            width: 100,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              message.sender!.userId,
                              style: const TextStyle(color: Color(0xFFADADAD)),
                            ),
                          ) // sender's name
                        : const SizedBox(),
                    !isMe
                        ? Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF46F9F5),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 200,
                  ),
                  child: Text(
                    message.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ), // message
              ],
            ),
          ),
          const SizedBox(width: 10),
          !isMe
              ? Text(
                  millisecsToReadableTime(message.createdAt),
                  style: const TextStyle(
                    color: Color(0xFF9C9CA3),
                    fontSize: 12,
                  ),
                ) // message time
              : const SizedBox()
        ],
      ),
    );
  }
}
