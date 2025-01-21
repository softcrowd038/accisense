import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/image_widget.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WideContainer extends StatelessWidget {
  const WideContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.005,
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.055,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.01,
                left: MediaQuery.of(context).size.width * 0.01,
              ),
              child: Consumer<AccidentDetectionProvider>(
                builder: (context, detected, _) {
                  return ImageWidget(
                    icon: detected.isAccidentDetected
                        ? "assets/images/warning.png"
                        : "assets/images/insurance.png",
                    height: MediaQuery.of(context).size.height * 0.0915,
                    width: MediaQuery.of(context).size.width * 0.0915,
                  );
                },
              ),
            ),
            Consumer<AccidentDetectionProvider>(
              builder: (context, detected, _) => TextWidget(
                text1: detected.isAccidentDetected
                    ? "Accident is detected!"
                    : "Everything is Fine!",
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
