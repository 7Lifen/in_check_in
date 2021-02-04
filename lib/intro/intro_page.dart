import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_check_in/app.dart';
import 'package:in_check_in/intro/user_selection.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends HookWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    showDialog(
      context: context,
      builder: (_) {
        // final Size _size = MediaQuery.of(_).size;
        return AlertDialog(
          elevation: 20,
          insetPadding: EdgeInsets.only(top: 80, bottom: 80, left: 5, right: 5),
          contentPadding: EdgeInsets.all(1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Are you..."),
          content: UserSelection(),
        );
      },
    );
  }

  Widget _buildImage(String assetName, Size size) {
    return Align(
      child: Image.asset(
        'assets/$assetName.jpg',
        width: size.width,
        height: size.height / 1.1,
        cacheHeight: 1000,
        cacheWidth: 1000,
        fit: BoxFit.fitWidth,
      ),
      alignment: Alignment.topCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    useProvider(userProvider);
    SystemChrome.setEnabledSystemUIOverlays([]);
    final Size _size = MediaQuery.of(context).size;
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700),
      // bodyTextStyle: bodyStyle,
      footerPadding: EdgeInsets.all(1),
      descriptionPadding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 1.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(1),
      bodyFlex: 2,
      titlePadding: EdgeInsets.all(1),
    );

    return IntroductionScreen(
      key: introKey,

      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create virtual waiting rooms",
                style: bodyStyle,
              ),
              _buildImage('list', _size),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Less queue management, more helping",
                style: bodyStyle,
              ),
              _buildImage('clinic', _size),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Optimize the customer experience",
                style: bodyStyle,
              ),
              _buildImage('line_up', _size),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Easily implement restrictions and guidelines",
                style: bodyStyle,
              ),
              _buildImage('store_limits', _size),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Save time for you and your patients",
                style: bodyStyle,
              ),
              _buildImage('time_smart', _size),
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        spacing: EdgeInsets.all(1),
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
