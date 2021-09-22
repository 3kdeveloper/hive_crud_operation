import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learn_hive_crud/models/contacts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _age;

  void addContacts(Contacts contact) {
    final contactsBox = Hive.box('contacts');
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildListView(),
              ),
              SizedBox(
                height: Get.height * 0.1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter your name'),
                      onSaved: (value) => _name = value,
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Enter your age'),
                      onSaved: (value) => _age = value,
                    )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  final newContact = Contacts(_name!, int.parse(_age!));
                  addContacts(newContact);
                  print('Contact added');
                },
                child: const Text('Add Contact'),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildListView() {
    final contactsBox = Hive.box('contacts');
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
        );
      },
    );
  }
}
