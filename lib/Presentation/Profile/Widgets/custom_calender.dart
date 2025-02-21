// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomCalendar(
      {super.key,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate});
  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    print(ProfilePageModel());
    final date2 = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate!,
      lastDate: widget.lastDate!,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      final difference = date2.difference(selectedDate).inDays;
      print(difference);
      final years = difference / 365;
      print(years.round());
      final birthDayProvider = Provider.of<User>(context, listen: false);
      birthDayProvider.setAge(years.round());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          readOnly: true,
          onTap: () => _selectDate(context),
          controller: TextEditingController(
            text:
                '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
          ),
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              labelText: 'Date',
              labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              hintText: 'Select Date',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: const Icon(
                Icons.calendar_month_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
              )),
        ),
      ],
    );
  }
}
