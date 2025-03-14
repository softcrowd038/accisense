import 'package:accident/Presentation/Profile/Pages/emergency_contact_page.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_textfield.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalHistoryPage extends StatefulWidget {
  const MedicalHistoryPage({super.key});

  @override
  State<MedicalHistoryPage> createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _allergiesController = TextEditingController();
  TextEditingController _medicalHistory = TextEditingController();

  @override
  void initState() {
    super.initState();

    _allergiesController = TextEditingController();
    _medicalHistory = TextEditingController();
  }

  void _updateAllergies(List<String> value) {
    Provider.of<User>(context, listen: false).setAllergies(value);
  }

  void _updateMedicalHistory(List<String> value) {
    Provider.of<User>(context, listen: false).setMedicalHistory(value);
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
              'step 5',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/doctors-analyzing-patients-disease-history_74855-16116.jpg')),
                      Text(
                        'enter your Medical History',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.018,
                            fontWeight: FontWeight.w300),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          onChanged: (value) {
                            _updateMedicalHistory(
                                value.split(',').map((e) => e.trim()).toList());
                          },
                          obscureText: false,
                          hint: "e.g. \"penicillin\", \"dust\"",
                          label: "allergies",
                          controller: _allergiesController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your allergies first!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          color: Colors.black,
                          suffixIcon: Icon(
                            Icons.vaccines,
                            color: Colors.black,
                            size: MediaQuery.of(context).size.height * 0.025,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          onChanged: (value) {
                            _updateAllergies(
                                value.split(',').map((e) => e.trim()).toList());
                          },
                          obscureText: false,
                          hint: "e.g. Asthama",
                          label: "Medical History",
                          controller: _medicalHistory,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your Details first!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          color: Colors.black,
                          suffixIcon: Icon(
                            Icons.medical_information,
                            color: Colors.black,
                            size: MediaQuery.of(context).size.height * 0.025,
                          ),
                        ),
                      ),
                    ],
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
                              builder: ((context) =>
                                  const ContactListScreen())));
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
      ),
    );
  }
}
