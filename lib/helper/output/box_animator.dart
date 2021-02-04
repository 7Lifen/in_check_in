import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

class Box extends StatelessWidget {
  final String text;
  final int delay;
  final bool string;
  final Widget widget;
  static final boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  const Box({Key key, this.text, this.delay, this.string, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      delay: Duration(
        milliseconds: delay.toInt(),
      ),
      duration: Duration(milliseconds: 200),
      tween: Tween(begin: 0.0, end: 80.0),
      builder: (context, height) {
        return ControlledAnimation(
          duration: Duration(milliseconds: 400),
          delay: Duration(milliseconds: 500 + delay),
          tween: Tween(begin: 2.0, end: 300.0),
          builder: (context, width) {
            return Container(
              decoration: boxDecoration,
              width: width,
              height: string ? height / 1.8 : height / 1.3,
              child: string
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: isEnoughRoomForTypewriter(width)
                          ? TypewriterText(msg: text)
                          : Container(),
                    )
                  : widget,
            );
          },
        );
      },
    );
  }

  isEnoughRoomForTypewriter(width) => width > 25;
}

class TypewriterText extends StatelessWidget {
  static const TEXT_STYLE =
      TextStyle(letterSpacing: 1, fontSize: 17, fontWeight: FontWeight.w300);

  final String msg;
  TypewriterText({this.msg});

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
        duration: Duration(milliseconds: 800),
        delay: Duration(milliseconds: 800),
        tween: IntTween(begin: 0, end: msg.length),
        builder: (context, textLength) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(msg.substring(0, textLength), style: TEXT_STYLE),
              ControlledAnimation(
                playback: Playback.LOOP,
                duration: Duration(milliseconds: 600),
                tween: IntTween(begin: 0, end: 1),
                builder: (context, oneOrZero) {
                  return Opacity(
                      opacity: oneOrZero == 1 ? 1.0 : 0.0,
                      child: Text("_", style: TEXT_STYLE));
                },
              )
            ],
          );
        });
  }
}
