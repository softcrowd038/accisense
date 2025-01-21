import 'dart:async';
import 'package:accident/Presentation/dashboard/components/moto_image_container.dart';
import 'package:flutter/material.dart';

class AutoCarouselIcon extends StatefulWidget {
  const AutoCarouselIcon({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AutoCarouselIconState createState() => _AutoCarouselIconState();
}

class _AutoCarouselIconState extends State<AutoCarouselIcon> {
  late ScrollController _scrollController;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentIndex < 6) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollToIndex(_currentIndex);
    });
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * MediaQuery.of(context).size.width,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(
              MediaQuery.sizeOf(context).height * 0.01,
            ),
            child: const MotoImageContainer(
              imageUrl:
                  'https://img.freepik.com/free-vector/motorcycle-cartoon-poster-with-biker-sport-clothing-riding-bike-vector-illustration_1284-79643.jpg?t=st=1737436743~exp=1737440343~hmac=03bbe7e665a6e4bff4697088f4a45fb244ad3592d81f3ea6c64406905125d542&w=996',
              message:
                  'Your helmet is your shield—don’t ride without it, \neven for a mile.',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              MediaQuery.sizeOf(context).height * 0.010,
            ),
            child: const MotoImageContainer(
              imageUrl:
                  'https://img.freepik.com/free-vector/car-driving-concept-illustration_114360-7981.jpg',
              message: 'Buckle up every time; it only takes a second.',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              MediaQuery.sizeOf(context).height * 0.010,
            ),
            child: const MotoImageContainer(
              imageUrl:
                  'https://img.freepik.com/free-vector/fast-car-concept-illustration_114360-2495.jpg',
              message: 'Speed thrills but kills.Slow down to live longer.',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              MediaQuery.sizeOf(context).height * 0.010,
            ),
            child: const MotoImageContainer(
              imageUrl:
                  'https://img.freepik.com/free-vector/drunk-driving-concept-illustration_114360-14318.jpg',
              message:
                  'Drink and drive, and you might not arrive. \nChoose safety, not regret.',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              MediaQuery.sizeOf(context).height * 0.010,
            ),
            child: const MotoImageContainer(
              imageUrl:
                  'https://cdn.vectorstock.com/i/500p/02/15/young-woman-using-mobile-phone-while-drive-vector-28980215.jpg',
              message:
                  'Eyes on the road, not on your phone. Texts can wait; \nlife cannot.',
            ),
          ),
        ],
      ),
    );
  }
}
