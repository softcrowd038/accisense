import 'package:accident/Presentation/Profile/Pages/emergency_contact_page.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:accident/Presentation/login_and_registration/Services/user_registration_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

class SelectedContactsScreen extends StatefulWidget {
  final List<Contact> selectedContacts;

  const SelectedContactsScreen({super.key, required this.selectedContacts});

  @override
  State<SelectedContactsScreen> createState() => _SelectedContactsScreenState();
}

class _SelectedContactsScreenState extends State<SelectedContactsScreen> {
  late List<TextEditingController> relationControllers;

  @override
  void initState() {
    super.initState();
    relationControllers = List.generate(
        widget.selectedContacts.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in relationControllers) {
      controller.dispose();
    }
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selected Contacts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedContacts.length,
              itemBuilder: (context, index) {
                Contact contact = widget.selectedContacts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading:
                        (contact.photo != null && contact.photo!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  _getInitials(contact.displayName),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                    title: Text(
                      contact.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.phones.isNotEmpty
                            ? contact.phones.first.number
                            : 'No phone number'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: relationControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Relation',
                            hintText:
                                'Enter relation for ${contact.displayName}',
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            String contactPhone = contact.phones.isNotEmpty
                                ? contact.phones.first.number
                                : '';
                            String contactName = contact.displayName;
                            final contactDetails =
                                Provider.of<User>(context, listen: false);
                            contactDetails.setEmergencyContacts([
                              EmergencyContact(
                                  name: contactName,
                                  relation: value,
                                  mobile: contactPhone)
                            ]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          widget.selectedContacts.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    UserRegistrationLogin userRegistrationLogin =
                        UserRegistrationLogin();
                    userRegistrationLogin.registerUser(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xff020053),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactListScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "SELECT CONTACTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
