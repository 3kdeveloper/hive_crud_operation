import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learn_hive_crud/models/contacts.dart';
import 'package:learn_hive_crud/widgets/build_contacts_list.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildContactsList(),
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
                      validator: (value) {
                        if (!GetUtils.isLengthGreaterThan(value, 2)) {
                          return 'Name must be greater then 3 char';
                        }
                      },
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Enter your age'),
                      onSaved: (value) => _age = value,
                      validator: (value) {
                        if (!GetUtils.isLengthBetween(value, 1, 150)) {
                          return 'Name must be between 150';
                        }
                      },
                    )),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final newContact = Contacts(_name!, int.parse(_age!));
                      addContacts(newContact);
                    }
                  },
                  child: const Text('Add Contact'),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
