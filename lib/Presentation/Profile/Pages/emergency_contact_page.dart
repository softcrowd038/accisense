// ignore_for_file: avoid_print
import 'package:accident/Presentation/Profile/Pages/show_selected_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  ContactListScreenState createState() => ContactListScreenState();
}

class ContactListScreenState extends State<ContactListScreen> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  final List<Contact> _selectedContacts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
    _searchController.addListener(_filterContacts);
  }

  Future<void> _fetchContacts() async {
    bool permission = await FlutterContacts.requestPermission();
    if (permission) {
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withAccounts: true,
      );

      for (var contact in contacts) {
        print('Name: ${contact.displayName}');
        print('Phones: ${contact.phones.map((e) => e.number).toList()}');
      }

      setState(() {
        _contacts = contacts;
        _filteredContacts = _contacts;
      });
    } else {
      print("Permission denied");
    }
  }

  // void _filterContacts() {
  //   final query = _searchController.text.toLowerCase();
  //   setState(() {
  //     _filteredContacts = _contacts.where((contact) {
  //       final name = contact.displayName.toLowerCase();
  //       return name.contains(query);
  //     }).toList();
  //   });
  // }

  void _toggleSelection(Contact contact) {
    setState(() {
      if (_selectedContacts.contains(contact)) {
        _selectedContacts.remove(contact);
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  void _navigateToSelectedContactsScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SelectedContactsScreen(
          selectedContacts: _selectedContacts,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.length > 1) {
      return nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return "?";
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        final name = contact.displayName.toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.check,
                color: _selectedContacts.isEmpty ? Colors.grey : Colors.white),
            onPressed: _selectedContacts.isEmpty
                ? () {}
                : _navigateToSelectedContactsScreen,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _contacts.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Wait a while, process takes some time!")
                ],
              ),
            )
          : _filteredContacts.isEmpty && _searchController.text.isNotEmpty
              ? const Center(
                  child: Text(
                    'No contacts found with the provided name.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredContacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = _filteredContacts[index];
                    bool isSelected = _selectedContacts.contains(contact);
                    return ListTile(
                      title: Text(contact.displayName),
                      subtitle: Text(contact.phones.isNotEmpty
                          ? contact.phones.map((e) => e.number).join(", ")
                          : 'No phone number'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: contact.thumbnail != null
                            ? MemoryImage(contact.thumbnail!)
                            : null,
                        child: contact.thumbnail == null
                            ? Text(
                                _getInitials(contact.displayName),
                                style: const TextStyle(color: Colors.white),
                              )
                            : null,
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      onTap: () => _toggleSelection(contact),
                    );
                  },
                ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
