import 'package:bql_test/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController messageInputController = TextEditingController();
  final MessagingController messagingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF131313),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: const Color(0xFF323232), width: 1.09),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageInputController,
                      onChanged: (value) => setState(() {}),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "메세지 보내기",
                        hintStyle: TextStyle(color: Color(0XFF666666)),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // do not send empty message
                      if (messageInputController.text.isEmpty) return;
                      messagingController.sendMessage(messageInputController);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        color: Color(
                          messageInputController.text.isEmpty
                              ? 0xFF323232
                              : 0xFFFF006A,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
