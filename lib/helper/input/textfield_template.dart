import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// ignore: must_be_immutable
class TextfieldTemplate extends HookWidget {
  final Function doNext;
  final bool showSuffixIcon;
  final TextEditingController ctrl;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final Size size;
  TextfieldTemplate({
    Key key,
    this.ctrl,
    this.hintText,
    this.focusNode,
    this.nextNode,
    this.size,
    this.showSuffixIcon,
    this.doNext,
  }) : super(key: key);
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    ctrl.text.trim();
    final _change = useState<bool>(false);
    return TextField(
      focusNode: focusNode,
      obscureText: showSuffixIcon ? _obscure : false,
      controller: ctrl,
      decoration: InputDecoration(
        suffixIcon: showSuffixIcon
            ? IconButton(
                icon: _obscure
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () {
                  _obscure = !_obscure;
                  _change.value = !_change.value;
                },
              )
            : Text(""),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        hintText: hintText,
      ),
      onEditingComplete: () {
        print("Editing complete");
        FocusScope.of(context).requestFocus(
          nextNode,
        );
        doNext();
        _change.value = !_change.value;
      },
      onSubmitted: (submitted) {
        print("Submitted: $submitted");
        doNext();
      },
      onChanged: (changed) {},
    );
  }
}
