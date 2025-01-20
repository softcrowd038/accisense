import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:accident/Presentation/Accident_Detection/services/accident_firebase_details.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/icon_widget.dart';

class AccidentListWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AccidentListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('accidents').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Accident> accidents = snapshot.data!.docs
            .map((doc) => Accident.fromFirestore(doc))
            .toList();

        return GestureDetector(
          onTap: () => {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView.builder(
              itemCount: accidents.length,
              itemBuilder: (context, index) {
                Accident accident = accidents[index];
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
                              color: Color.fromARGB(255, 219, 219, 219))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.012),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    accident.location,
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
                            height: MediaQuery.of(context).size.height * 0.014,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    size: MediaQuery.of(context).size.height *
                                        0.025,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      accident.date,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016,
                                        color: const Color.fromARGB(
                                            255, 94, 94, 94),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.av_timer,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          accident.time,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.016,
                                            color:
                                                Color.fromARGB(255, 94, 94, 94),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDeleteConfirmationDialog(
                                      context, accident);
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Accident accident) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this accident?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                try {
                  await Accident.deleteAccident(accident.id);
                  // ignore: use_build_context_synchronously
                  Navigator.of(dialogContext).pop(); // Close the dialog
                } catch (e) {
                  // Handle error if needed
                  // ignore: avoid_print
                  print('Error deleting accident: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
