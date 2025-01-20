import 'package:accident/Presentation/Profile/Pages/birthday_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  GenderPageState createState() => GenderPageState();
}

class GenderPageState extends State<GenderPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              'step 3',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<ProfilePageModel>(
            builder: (context, genderProvider, _) {
              return Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "select your gender",
                      style: TextStyle(
                        color: const Color(0xff020053),
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/malegender.png",
                                height: size.height * 0.09,
                                width: size.height * 0.09,
                              ),
                              Image.asset(
                                "assets/images/female.jpg",
                                height: size.height * 0.11,
                                width: size.height * 0.11,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: size.height * 0.060),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: 'Male',
                                    activeColor: const Color(0xff020053),
                                    groupValue: genderProvider.gender,
                                    onChanged: (value) {
                                      genderProvider.setGender(value!);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BirthDatePage()));
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: 'Female',
                                    activeColor: const Color(0xff020053),
                                    groupValue: genderProvider.gender,
                                    onChanged: (value) {
                                      genderProvider.setGender(value!);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BirthDatePage()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
