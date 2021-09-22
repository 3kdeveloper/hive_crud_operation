import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn_hive_crud/models/contacts.dart';

Widget buildContactsList() {
  return WatchBoxBuilder(
    box: Hive.box('contacts'),
    builder: (context, contactsBox) {
      return ListView.builder(
        itemCount: contactsBox.length,
        itemBuilder: (context, index) {
          final contact = contactsBox.getAt(index) as Contacts;
          return ListTile(
            title: Text(
              contact.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              contact.age.toString(),
              style: const TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
                onPressed: () {
                  //TODO Delete Contact from hive database
                  Hive.box('contacts').deleteAt(index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          );
        },
      );
    },
  );
}
