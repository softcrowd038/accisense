import 'package:accident/Presentation/Profile/Pages/emergency_contact_page.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_calender.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:flutter/material.dart';

class BirthDatePage extends StatefulWidget {
  const BirthDatePage({super.key});

  @override
  State<BirthDatePage> createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
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
              'step 4',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/images/birthday.png")),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "select your birthday 🎉 ",
                style: TextStyle(
                    color: const Color(0xff020053),
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomCalendar(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1800),
                  lastDate: DateTime(2300)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ContactListScreen())));
              },
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.008),
                child: const CustomButton(
                  buttonText: "Next",
                ),
              ),
            ),
          ]),
    );
  }
}
