// ignore_for_file: avoid_print
import 'package:accident/Presentation/Profile/Pages/show_selected_contacts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
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

  // Future<void> _requestPermission() async {
  //   if (await Permission.contacts.request().isGranted) {
  //     _fetchContacts();
  //   } else {
  //     print("did not get permission");
  //   }
  // }

  Future<void> _fetchContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
      _filteredContacts = _contacts;
    });
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        final name = contact.displayName?.toLowerCase() ?? '';
        return name.contains(query);
      }).toList();
    });
  }

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
                color:
                    _selectedContacts.length < 2 ? Colors.grey : Colors.white),
            onPressed: _selectedContacts.length < 2
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
      body: _filteredContacts.isEmpty
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Wait a while, process takes some time!")
              ],
            ))
          : ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                Contact contact = _filteredContacts[index];
                bool isSelected = _selectedContacts.contains(contact);
                return ListTile(
                  title: Text(contact.displayName ?? 'No name'),
                  subtitle: Text(contact.phones?.isNotEmpty ?? false
                      ? contact.phones!.first.value!
                      : 'No phone number'),
                  leading:
                      (contact.avatar != null && contact.avatar!.isNotEmpty)
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar!),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                contact.initials(),
                                style: const TextStyle(color: Colors.white),
                              ),
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
