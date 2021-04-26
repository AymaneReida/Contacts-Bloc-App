import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/message.model.dart';

class MessagesState {
  RequestState requestState;
  List<Message> messages;
  String errorMessage;
  MessagesEvent currentMessageEvent;

  MessagesState(
      {this.requestState,
      this.messages,
      this.errorMessage,
      this.currentMessageEvent});

  MessagesState.initialState()
      : messages = [],
        errorMessage = '',
        requestState = RequestState.NONE;
}
