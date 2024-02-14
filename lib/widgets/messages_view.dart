import 'package:bql_test/controllers/messages_controller.dart';
import 'package:bql_test/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final MessagingController messagingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: ListView.builder(
          reverse: true,
          itemCount: messagingController.messages.length,
          itemBuilder: (context, index) {
            final reversedIndex =
                messagingController.messages.length - 1 - index;
            BaseMessage message_ = messagingController.messages[reversedIndex];
            Sender? sender = message_.sender;
            if (sender == null) return const SizedBox();
            return MessageBubble(
              message: message_,
              isMe: sender.isCurrentUser,
            );
          },
        ),
      ),
    );
  }
}
