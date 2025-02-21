import 'package:accident/Presentation/Profile/Pages/profile_details.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:accident/Presentation/login_and_registration/Services/signup_signin.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/common_textform_field.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _reEnterPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final regexe = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
  final regexpa =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _reEnterPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  void _updateUsername(String value) {
    Provider.of<User>(context, listen: false).setUsername(value);
  }

  void _updateEmail(String value) {
    Provider.of<User>(context, listen: false).setEmail(value);
  }

  void _updatePassword(String value) {
    Provider.of<User>(context, listen: false).setPassword(value);
  }

  void _updateReEnteredPassword(String value) {
    Provider.of<User>(context, listen: false).setPasswordConfirmation(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff020053),
      body: Consumer<UserCredentials>(
        builder: (context, userCredentials, child) => Form(
          key: _formKey,
          child: OrientationBuilder(
            builder: (context, orientation) => SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.0200,
                        ),
                        child: Stack(
                          children: [
                            Image(
                                image: const AssetImage(
                                  'assets/images/logo1.png',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.180,
                                width:
                                    MediaQuery.of(context).size.height * 0.180),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.140,
                              left: MediaQuery.of(context).size.height * 0.045,
                              child: Text(
                                'ACCIDETECT',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0140,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      ClipPath(
                        clipper: CustomDiagonalClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, bottom: 8.0),
                                  child: Center(
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.008,
                                  right: MediaQuery.of(context).size.height *
                                      0.008,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                child: CommonTextFormfield(
                                  onChanged: (value) {
                                    _updateUsername(value);
                                  },
                                  label: "Username",
                                  hint: "Peter Parker",
                                  obscure: false,
                                  controller: _usernameController,
                                  suffixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the Username first!";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.008,
                                  right: MediaQuery.of(context).size.height *
                                      0.008,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                child: CommonTextFormfield(
                                  onChanged: (value) {
                                    _updateEmail(value);
                                  },
                                  label: "Email",
                                  hint: "xyz@abc.pqr",
                                  obscure: false,
                                  controller: _emailController,
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the Email first!";
                                    }
                                    if (!regexe.hasMatch(value)) {
                                      return "Enter Valid Email Format!";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.008,
                                  right: MediaQuery.of(context).size.height *
                                      0.008,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                child: CommonTextFormfield(
                                  onChanged: (value) {
                                    _updatePassword(value);
                                  },
                                  label: "Password",
                                  hint: "MNop1234@#",
                                  obscure: true,
                                  controller: _passwordController,
                                  suffixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the Password first!";
                                    }
                                    if (value.length < 8) {
                                      return "Password is too short, Enter up to 8 digits!";
                                    }
                                    if (!regexpa.hasMatch(value)) {
                                      return "Use Alphabets(capital and small), symbols and numbers only in the password";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.008,
                                  right: MediaQuery.of(context).size.height *
                                      0.008,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                child: CommonTextFormfield(
                                  onChanged: (value) {
                                    _updateReEnteredPassword(value);
                                  },
                                  label: "Re-Enter Password",
                                  hint: "MNop1234@#",
                                  obscure: true,
                                  controller: _reEnterPasswordController,
                                  suffixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the Password first!";
                                    }
                                    if (value.length < 8) {
                                      return "Password is too short, Enter up to 8 digits!";
                                    }
                                    if (!regexpa.hasMatch(value)) {
                                      return "Use Alphabets(capital and small), symbols and numbers only in the password";
                                    }
                                    if (_passwordController.text != value) {
                                      return 'Password do not match';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileDetails()));
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.008,
                                    right: MediaQuery.of(context).size.height *
                                        0.008,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.010,
                                    top: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  child: const CustomButton(
                                    buttonText: "Signup",
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: Text(
                                        "Signin",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double borderRadius = 20.0; // Radius for rounded corners
    double trimPercentage = 0.25; // 25% trim on left and right sides

    Path path = Path();

    // Start from the top-left corner
    path.moveTo(0, borderRadius);

    // Top-left rounded corner
    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );

    // Move to the left trim point (25% of width)
    double leftTrimX = size.width * trimPercentage;
    path.lineTo(leftTrimX, 0);

    // Line to the middle of the top
    path.lineTo(size.width / 2, size.height * 0.1);

    // Line to the right trim point (25% of width from the right)
    double rightTrimX = size.width * (1 - trimPercentage);
    path.lineTo(rightTrimX, 0);

    // Top-right rounded corner
    path.arcToPoint(
      Offset(size.width, borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );

    // Line down the right side
    path.lineTo(size.width, size.height);

    // Line across the bottom
    path.lineTo(0, size.height);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
