import 'package:contacts_bloc_app/model/message.model.dart';
import 'package:contacts_bloc_app/ui/pages/messages/widgets/message.item.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesListWidget extends StatelessWidget {
  List<Message> messages;

  ScrollController scrollController = new ScrollController();

  MessagesListWidget({this.messages});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        this.scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) =>
            MessageItemWidget(message: this.messages[index]),
        separatorBuilder: (context, index) => Divider(
              color: Color(0xff5e2750),
              height: 2,
            ),
        itemCount: messages.length);
  }
}
