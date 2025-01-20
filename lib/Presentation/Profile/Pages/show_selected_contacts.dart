// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/emergency_contact_page.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedContactsScreen extends StatefulWidget {
  final List<Contact> selectedContacts;

  const SelectedContactsScreen({super.key, required this.selectedContacts});

  @override
  State<SelectedContactsScreen> createState() => _SelectedContactsScreenState();
}

class _SelectedContactsScreenState extends State<SelectedContactsScreen> {
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
                );
              },
            ),
          ),
          widget.selectedContacts != null && widget.selectedContacts.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    String contact1Phone =
                        widget.selectedContacts[0].phones?.isNotEmpty == true
                            ? widget.selectedContacts[0].phones!.first.value ??
                                ''
                            : '';
                    final profilePageProvider =
                        Provider.of<ProfilePageModel>(context, listen: false);
                    FireStoreProfileData().storeUserData(
                      profilePageProvider.imageurl,
                      profilePageProvider.name,
                      profilePageProvider.email,
                      profilePageProvider.phone,
                      widget.selectedContacts[0].displayName ?? '',
                      'friend',
                      contact1Phone,
                      profilePageProvider.address,
                      profilePageProvider.birthdate,
                      profilePageProvider.gender,
                    );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePage())));
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
