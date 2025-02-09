import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import '../core/permission.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool granted = await Permissions.requestContactsPermission();
    if (granted) {
      _fetchContacts();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission Denied! Cannot fetch contacts.")),
      );
    }
  }

  Future<void> _fetchContacts() async {
    Iterable<Contact> fetchedContacts = await ContactsService.getContacts();
    setState(() {
      contacts = fetchedContacts.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: contacts.isEmpty
          ? Center(child: Text('No contacts available'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index].displayName ?? 'No Name'),
                  subtitle: contacts[index].phones!.isNotEmpty
                      ? Text(contacts[index].phones!.first.value!)
                      : Text('No Number'),
                );
              },
            ),
    );
  }
}
