import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import '../services/contact_service.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactService _contactService = ContactService();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    List<Contact> contacts = await _contactService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        Contact contact = _contacts[index];
        return ListTile(
          title: Text(contact.displayName ?? "No Name"),
          subtitle: Text(contact.phones!.isNotEmpty
              ? contact.phones!.first.value!
              : "No Number"),
        );
      },
    );
  }
}
