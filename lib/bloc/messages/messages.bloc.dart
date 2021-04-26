import 'package:bloc/bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/message.model.dart';
import 'package:contacts_bloc_app/repositories/messages.repository.dart';
import 'package:flutter/cupertino.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesRepository messagesRepository;

  MessagesBloc({@required MessagesState initialState, this.messagesRepository})
      : super(initialState);

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    if (event is MessagesByContactsEvent) {
      yield MessagesState(
          requestState: RequestState.LOADING,
          messages: state.messages,
          currentMessageEvent: event);
      try {
        List<Message> data =
            await messagesRepository.allMessagesByContact(event.payload.id);
        yield MessagesState(
            requestState: RequestState.LOADED,
            messages: data,
            currentMessageEvent: event);
      } catch (e) {
        yield MessagesState(
            requestState: RequestState.ERROR,
            messages: state.messages,
            errorMessage: e.toString(),
            currentMessageEvent: event);
      }
    } else if (event is AddNewMessageEvent) {
      /* yield MessagesState(
          requestState: RequestState.LOADING,
          messages: state.messages,
          currentMessageEvent: event); */
      try {
        event.payload.date = DateTime.now();
        Message message = await messagesRepository.addNewMessage(event.payload);
        List<Message> data = [...state.messages];
        data.add(message);
        yield MessagesState(
            requestState: RequestState.LOADED,
            messages: data,
            currentMessageEvent: event);
      } catch (e) {
        yield MessagesState(
            requestState: RequestState.ERROR,
            messages: state.messages,
            errorMessage: e.message,
            currentMessageEvent: event);
      }
    }
  }
}
