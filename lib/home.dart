import 'package:bql_test/controllers/messages_controller.dart';
import 'package:bql_test/widgets/message_input.dart';
import 'package:bql_test/widgets/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class Home extends StatefulWidget with ChannelEventHandler {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  MessagingController messagingController = Get.put(MessagingController());

  @override
  void initState() {
    super.initState();
    messagingController.joinOpenChannel().catchError((err) => ());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => messagingController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(0xFFFF006B),
            ))
          : Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 30),
                title: const Text(
                  "강남스팟",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),
                ],
              ),
              bottomSheet: const MessageInput(),
              body: messagingController.messages.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: const Center(
                        child: Text('No messages'),
                      ),
                    )
                  : const MessagesView(),
            ),
    );
  }
}
