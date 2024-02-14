import 'package:bql_test/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessagingController extends GetxController {
  RxList<dynamic> messages = [].obs;
  RxBool isLoading = true.obs;
  OpenChannel? openChannel;

  Future<void> joinOpenChannel() async {
    try {
      isLoading.value = true;

      // connect user to the Sendbird service
      await SendbirdChat.connect(currentUserID);

      // get the open channel. this is done to make sure the channel exists before joining
      OpenChannel openChannel = await OpenChannel.getChannel(openChannelURL);

      // join the open channel
      await openChannel.enter();

      this.openChannel = openChannel;

      // fetch all previous messages from the channel
      List<BaseMessage> messages_ = await PreviousMessageListQuery(
        channelType: ChannelType.open,
        channelUrl: openChannelURL,
      ).next();

      messages.value = messages_;
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
    }
  }

  // sends a message to the open channel
  void sendMessage(TextEditingController messageInputController) async {
    try {
      // create a new user message
      final params = UserMessageCreateParams(
        message: messageInputController.text,
      );

      // send the message
      openChannel?.sendUserMessage(params, handler: (message, e) {
        if (e != null) return;
        messages.add(message);
        messageInputController.clear();
      });
    } catch (err) {
      // handle error
    }
  }
}
