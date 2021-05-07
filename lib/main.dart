import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/repositories/contacts.repository.dart';
import 'package:contacts_bloc_app/repositories/messages.repository.dart';
import 'package:contacts_bloc_app/ui/pages/contacts/contacts.page.dart';
import 'package:contacts_bloc_app/ui/pages/contactsWithMessages/contacts.messages.page.dart';
import 'package:contacts_bloc_app/ui/pages/messages/messages.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc/contacts/contacts.bloc.dart';
import 'bloc/contacts/contacts.state.dart';
import 'bloc/messages/messages.state.dart';
import 'enums/enums.dart';

void main() {
  GetIt.instance.registerLazySingleton(() => new ContactsRepository());
  GetIt.instance.registerLazySingleton(() => new MessagesRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MessagesBloc(
                  initialState: MessagesState.initialState(),
                  messagesRepository: GetIt.instance<MessagesRepository>(),
                )),
        BlocProvider(
            create: (context) => ContactsBloc(
                  initialState: ContactsState(
                      contacts: [],
                      errorMessage: '',
                      requestState: RequestState.NONE),
                  contactsRepository: GetIt.instance<ContactsRepository>(),
                  messagesBloc: context.read<MessagesBloc>(),
                )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: MaterialColor(0xff5e2750, {
          50: Color(0xff5e2750),
          100: Color(0xff5e2750),
          200: Color(0xff5e2750),
          300: Color(0xff5e2750),
          400: Color(0xff5e2750),
          500: Color(0xff5e2750),
          600: Color(0xff5e2750),
          700: Color(0xff5e2750),
          800: Color(0xff5e2750),
          900: Color(0xff5e2750),
        })),
        routes: {
          '/contacts': (context) => ContactsPage(),
          '/messages': (context) => MessagesPage(),
          '/contactsWithMessages': (context) => ContactsWithMessages(),
        },
        initialRoute: '/contactsWithMessages',
      ),
    );
  }
}
