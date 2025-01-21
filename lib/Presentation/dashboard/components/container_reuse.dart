import 'package:accident/Presentation/dashboard/components/seconadary_components/icon_widget.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/text_widget.dart';
import 'package:flutter/material.dart';

class ReuseContainer extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final String value;
  final String title;
  final IconData icon;
  final double? height;
  final double? width;
  final double? size;

  const ReuseContainer(
      {super.key,
      required this.color,
      required this.value,
      required this.title,
      required this.icon,
      required this.height,
      required this.width,
      required this.size,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                    spreadRadius: 2)
              ]),
          child: IconWidget(
            icon: icon,
            size: size,
            color: iconColor,
          ),
        ),
        TextWidget(
          text1: value,
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height * 0.018,
          fontWeight: FontWeight.bold,
        ),
        TextWidget(
          text1: title,
          color: Colors.grey,
          fontSize: MediaQuery.of(context).size.height * 0.016,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
