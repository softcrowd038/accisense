import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/Presentation/login_and_registration/Services/user_registration_login.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/common_textform_field.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:accident/Presentation/login_and_registration/pages/registration_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _reEnterPasswordController =
      TextEditingController();
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

  void _updateEmail(String value) {
    Provider.of<UserCredentials>(context, listen: false).setEmail(value);
  }

  void _updatePassword(String value) {
    Provider.of<UserCredentials>(context, listen: false).setPassword(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffad2c24),
      body: Consumer<UserCredentials>(
        builder: (context, userCredentials, child) => Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.0200,
                  ),
                  child: Stack(
                    children: [
                      Image(
                          image: const AssetImage(
                            'assets/images/logo6.png',
                          ),
                          height: MediaQuery.of(context).size.height * 0.180,
                          width: MediaQuery.of(context).size.height * 0.180),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.140,
                        left: MediaQuery.of(context).size.height * 0.045,
                        child: Text(
                          'ACCISENSE',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.0140,
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
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            bottom: MediaQuery.of(context).size.height * 0.008,
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
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            bottom: MediaQuery.of(context).size.height * 0.008,
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
                                return "Use Alphabets(capital and small), symbols and numbers in the password";
                              }
                              return null;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              UserRegistrationLogin userRegistrationLogin =
                                  UserRegistrationLogin();
                              userRegistrationLogin.loginUser(
                                  context,
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.008),
                            child: const CustomButton(
                              buttonText: "Log In",
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
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
                                            const RegistrationPage()));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
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
    double borderRadius = 20.0;
    double trimPercentage = 0.25;

    Path path = Path();

    path.moveTo(0, borderRadius);

    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
      clockwise: false,
    );

    double leftTrimX = size.width * trimPercentage;
    path.lineTo(leftTrimX, 0);

    path.lineTo(size.width / 2, size.height * 0.1);

    double rightTrimX = size.width * (1 - trimPercentage);
    path.lineTo(rightTrimX, 0);

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
