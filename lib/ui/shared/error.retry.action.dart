import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorRetryMessage extends StatelessWidget {
  String errorMessage;
  Function onAction;

  ErrorRetryMessage({this.errorMessage, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${errorMessage}"),
        RaisedButton(
          onPressed: onAction,
          child: Text(
            'Retry',
            style: TextStyle(color: Colors.white),
          ),
          color: Color(0xff5e2750),
        ),
      ],
    );
  }
}
