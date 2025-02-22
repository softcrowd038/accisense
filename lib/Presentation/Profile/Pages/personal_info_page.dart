import 'package:accident/Presentation/Profile/Pages/gender_page.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_textfield.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  void _updatePhone(String value) {
    Provider.of<User>(context, listen: false).setMobileNumber(value);
  }

  void _updateAdress(String value) {
    Provider.of<User>(context, listen: false).setAddress(value);
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
              'step 2',
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
                    children: [
                      const Image(
                          image: NetworkImage(
                              'https://cdni.iconscout.com/illustration/premium/thumb/user-profile-illustration-download-in-svg-png-gif-file-formats--id-login-register-technology-pack-network-communication-illustrations-2928727.png?f=webp')),
                      Text(
                        'enter your profile details',
                        style: TextStyle(
                            color: const Color(0xff020053),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.018,
                            fontWeight: FontWeight.w300),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: CustomTextField(
                      //     onChanged: (value) {
                      //       _updateEmail(value);
                      //     },
                      //     obscureText: false,
                      //     hint: "xyz123@pqr.abc",
                      //     label: "email",
                      //     controller: _emailController,
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return "Enter your Email first!";
                      //       }
                      //       return null;
                      //     },
                      //     keyboardType: TextInputType.emailAddress,
                      //     color: Colors.black,
                      //     suffixIcon: Icon(
                      //       Icons.email,
                      //       color: Colors.black,
                      //       size: MediaQuery.of(context).size.height * 0.025,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          onChanged: (value) {
                            _updateAdress(value);
                          },
                          obscureText: false,
                          hint:
                              "John Doe123, Main Street,Gandhi Nagar,Bangalore,Karnataka - 560001,India",
                          label: "address",
                          controller: _addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your Emergency Phone first!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          color: Colors.black,
                          suffixIcon: Icon(
                            Icons.home,
                            color: Colors.black,
                            size: MediaQuery.of(context).size.height * 0.025,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          onChanged: (value) {
                            _updatePhone(value);
                          },
                          obscureText: false,
                          hint: "+91 1234567890",
                          label: "phone",
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your Phone first!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          color: Colors.black,
                          suffixIcon: Icon(
                            Icons.phone,
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
                              builder: ((context) => const GenderPage())));
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
