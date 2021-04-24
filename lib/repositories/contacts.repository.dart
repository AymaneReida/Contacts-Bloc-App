import 'dart:math';

import 'package:contacts_bloc_app/model/contact.model.dart';

class ContactsRepository {
  Map<int, Contact> contacts = {
    1: Contact(
        id: 1, name: 'Aymane', profile: 'AY', type: 'Student', score: 7175),
    2: Contact(
        id: 2, name: 'Mohamed', profile: 'MO', type: 'Developer', score: 9999),
    3: Contact(
        id: 3, name: 'Hanane', profile: 'HA', type: 'Student', score: 567),
    4: Contact(
        id: 4, name: 'Ahmed', profile: 'AH', type: 'Developer', score: 175),
    5: Contact(
        id: 5, name: 'Imane', profile: 'IM', type: 'Student', score: 6574),
  };

  Future<List<Contact>> allContacts() async {
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if (rnd > 1) {
      return contacts.values.toList();
    } else {
      throw new Exception("Internet Error");
    }
  }

  Future<List<Contact>> contactsByType(String type) async {
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if (rnd > 1) {
      return contacts.values
          .toList()
          .where((element) => element.type == type)
          .toList();
    } else {
      throw new Exception("Internet Error");
    }
  }
}
