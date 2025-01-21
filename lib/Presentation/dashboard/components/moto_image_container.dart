import 'package:flutter/material.dart';

class MotoImageContainer extends StatefulWidget {
  final String imageUrl;
  final String message;

  const MotoImageContainer({
    Key? key,
    required this.imageUrl,
    required this.message,
  }) : super(key: key);

  @override
  State<MotoImageContainer> createState() => _MotoImageContainerState();
}

class _MotoImageContainerState extends State<MotoImageContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: height * 0.008,
              right: height * 0.008,
              bottom: height * 0.008),
          child: Row(
            children: [
              SizedBox(
                child: Text(
                  widget.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.25,
          width: width * 0.95,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.circular(height * 0.008),
          ),
        ),
      ],
    );
  }
}
