// ignore_for_file: unused_element
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/personal_info_page.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_textfield.dart';
import 'package:accident/Presentation/Profile/Widgets/profile_picture.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
  }

  void _updateName(String value) {
    Provider.of<ProfilePageModel>(context, listen: false).setName(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'CREATE YOUR ACCOUNT',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height * 0.018,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color.fromARGB(255, 177, 177, 177),
              size: MediaQuery.of(context).size.height * 0.018,
            ),
            Text(
              'step 1',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfilePictureField(isEdit: false),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.008),
                  child: CustomTextField(
                    onChanged: (value) {
                      _updateName(value);
                    },
                    obscureText: false,
                    hint: "eg. John Doe",
                    label: "name",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your Name first!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    color: Colors.black,
                    suffixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.height * 0.025,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const PersonalInfoPage())));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.008),
                  child: const CustomButton(
                    buttonText: "Next",
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
