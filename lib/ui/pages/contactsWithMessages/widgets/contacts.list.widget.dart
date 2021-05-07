import 'package:contacts_bloc_app/bloc/contacts/contacts.bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts/contacts.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/ui/shared/circular.progress.indicator.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListHorizontalWidget extends StatelessWidget {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
      if (state.requestState == RequestState.LOADING) {
        return MyCircularProgressIndicatorIndicatorWidget();
      } else if (state.requestState == RequestState.ERROR) {
        return ErrorRetryMessage(
          errorMessage: state.errorMessage,
          onAction: () {
            context.read<ContactsBloc>().add(state.currentEvent);
          },
        );
      } else if (state.requestState == RequestState.LOADED) {
        return SizedBox(
          height: 150,
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  context
                      .read<MessagesBloc>()
                      .add(new MessagesByContactsEvent(state.contacts[index]));
                  scrollController.animateTo((index * 200 - 150).toDouble(),
                      duration: Duration(microseconds: 2000),
                      curve: Curves.ease);
                },
                child: BlocBuilder<MessagesBloc, MessagesState>(
                  builder: (context, messagesState) => Card(
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: 150,
                      child: Column(children: [
                        CircleAvatar(
                          child: Text('${state.contacts[index].profile}'),
                        ),
                        Text('${state.contacts[index].name}'),
                        Text('${state.contacts[index].score}'),
                      ]),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: (messagesState.currentContact ==
                                  state.contacts[index])
                              ? 3
                              : 1,
                          color: Color(0xff5e2750),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            itemCount: state.contacts.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
