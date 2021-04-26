import 'package:contacts_bloc_app/model/message.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageItemWidget extends StatelessWidget {
  Message message;

  MessageItemWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: (message.type == 'sent')
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          (message.type == 'sent')
              ? SizedBox(
                  width: 40,
                )
              : SizedBox(
                  width: 0,
                ),
          Flexible(
            child: Container(
              color: (message.type == 'sent')
                  ? Color.fromARGB(20, 0, 255, 0)
                  : Color.fromARGB(20, 255, 0, 0),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (message.type == 'sent') ? Colors.green : Colors.red,
                    width: 1,
                  )),
              child: Text(
                  '${message.content} (${message.date.day}/${message.date.month}/${message.date.year}-${message.date.hour}:${message.date.minute})'),
            ),
          ),
          (message.type == 'received')
              ? SizedBox(
                  width: 40,
                )
              : SizedBox(
                  width: 0,
                ),
        ],
      ),
    );
  }
}
