// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:accident/Presentation/Profile/Model/user_accident_details.dart';
import 'package:accident/Presentation/Profile/Services/user_accident_history_service.dart';
import 'package:intl/intl.dart';

class AccidentListWidget extends StatefulWidget {
  const AccidentListWidget({Key? key}) : super(key: key);

  @override
  State<AccidentListWidget> createState() => _AccidentListWidgetState();
}

class _AccidentListWidgetState extends State<AccidentListWidget> {
  List<UserAccidentHistory?> _accidents = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      UserAccidentHistoryService userData = UserAccidentHistoryService();
      final List<UserAccidentHistory?> userProfileDetails =
          await userData.getUserAccidentHistory();
      setState(() {
        _accidents = userProfileDetails;
      });
    } catch (e) {
      print('Error fetching accident data: $e');
    }
  }

  String formatDateToYYYYMMDD(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Color statusColor(String value) {
    if (value == 'reported') {
      return Colors.red;
    } else if (value == 'in_progress') {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.50,
        width: MediaQuery.of(context).size.width,
        child: _accidents.isNotEmpty
            ? ListView.builder(
                itemCount: _accidents.length,
                itemBuilder: (context, index) {
                  final accident = _accidents[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            color: Color.fromARGB(255, 219, 219, 219),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.red,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    accident!.address ?? "Unknown Location",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.014),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: MediaQuery.of(context).size.height *
                                        0.01,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      formatDateToYYYYMMDD(accident.createdAt!)
                                          .toString(),
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
                                        color: const Color.fromARGB(
                                            255, 94, 94, 94),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: MediaQuery.of(context).size.height *
                                        0.01,
                                    color: statusColor(accident.status!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      accident.status ?? '',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'No data Found',
                  style: TextStyle(color: Colors.black),
                ),
              ));
  }
}
