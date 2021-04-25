import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  Contact contact;

  @override
  Widget build(BuildContext context) {
    this.contact = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages de ${contact.name}'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text('${contact.profile}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('${contact.name}'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Text('Messages List'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.bottomLeft,
            child: Text('Messages Form'),
          )
        ],
      ),
    );
  }
}
