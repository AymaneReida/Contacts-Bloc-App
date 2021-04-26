import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/ui/pages/messages/widgets/contact.info.widget.dart';
import 'package:contacts_bloc_app/ui/pages/messages/widgets/messages.form.widget.dart';
import 'package:contacts_bloc_app/ui/pages/messages/widgets/messages.list.widget.dart';
import 'package:contacts_bloc_app/ui/shared/circular.progress.indicator.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesPage extends StatelessWidget {
  Contact contact;

  @override
  Widget build(BuildContext context) {
    this.contact = ModalRoute.of(context).settings.arguments;
    context.read<MessagesBloc>().add(MessagesByContactsEvent(this.contact));
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages de ${contact.name}'),
      ),
      body: Column(
        children: [
          ContactInfoWidget(
            contact: this.contact,
          ),
          Expanded(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state.requestState == RequestState.LOADING) {
                  return MyCircularProgressIndicatorIndicatorWidget();
                } else if (state.requestState == RequestState.ERROR) {
                  return ErrorRetryMessage(
                    errorMessage: state.errorMessage,
                    onAction: () {
                      context
                          .read<MessagesBloc>()
                          .add(state.currentMessageEvent);
                    },
                  );
                } else if (state.requestState == RequestState.LOADED) {
                  return MessagesListWidget(
                    messages: state.messages,
                  );
                } else if (state.requestState == RequestState.NONE) {
                  return Container();
                }
              },
            ),
          ),
          MessagesFormWidget(
            contact: this.contact,
          ),
        ],
      ),
    );
  }
}
