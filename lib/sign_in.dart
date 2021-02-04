import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:in_check_in/handlers/auth.dart';
import 'package:in_check_in/helper/input/textfield_template.dart';
import 'package:in_check_in/helper/output/box_animator.dart';

// ignore: must_be_immutable
class SignInPage extends HookWidget {
  bool _showPassword = false;
  bool _showButton = false;
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  GlobalKey<ScaffoldState> _signInScaffoldKey =
      new GlobalKey<ScaffoldState>(debugLabel: "SignInView");
  final FocusNode _passwordNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final _change = useState<bool>(false);
    var _size = MediaQuery.of(context).size;
    final AuthHandler _authHandler = AuthHandler();
    return Scaffold(
      key: _signInScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Sign-In"),
        centerTitle: true,
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 13,
            ),
            Center(
              child: Box(
                delay: 500,
                string: false,
                widget: Container(
                  height: _size.height / 11,
                  width: _size.width / 1.3,
                  child: TextfieldTemplate(
                    showSuffixIcon: false,
                    doNext: () {
                      _showPassword = true;
                      _change.value = !_change.value;
                    },
                    size: _size,
                    ctrl: _emailCtrl,
                    nextNode: FocusNode(),
                    hintText: "Enter your email",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            _showPassword
                ? Center(
                    child: Box(
                      delay: 400,
                      string: false,
                      widget: Center(
                        child: TextfieldTemplate(
                          nextNode: FocusNode(),
                          showSuffixIcon: true,
                          doNext: () {
                            _showButton = true;
                            _change.value = !_change.value;
                          },
                          size: _size,
                          focusNode: _passwordNode,
                          ctrl: _passwordCtrl,
                          hintText: "Enter your password",
                        ),
                      ),
                    ),
                  )
                : Text(""),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 30,
            ),
            _showButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                          fillColor: Colors.lightGreen,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Sign-In",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(
                              new FocusNode(),
                            );

                            var currentUser =
                                await _authHandler.signInWithEmailPassword(
                                    email: _emailCtrl.text,
                                    password: _passwordCtrl.text,
                                    context: context);
                            if (currentUser != null) {
                              print("$currentUser != null");
                            }
                            // if (currentUser == null) {
                            //   showDialog(
                            //     context: context,
                            //     builder: (_) {
                            //       return AlertDialog(
                            //         title: Center(
                            //           child: Text(
                            //             "Error",
                            //             style: TextStyle(color: Colors.red),
                            //           ),
                            //         ),
                            //         content: Column(
                            //           children: [
                            //             Text(
                            //                 "No account was found, do you want to sign-up?"),
                            //             Center(
                            //               child: RawMaterialButton(
                            //                 elevation: 20,
                            //                 fillColor: Colors.green,
                            //                 shape: RoundedRectangleBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(20),
                            //                 ),
                            //                 child: Text("Sign-Up"),
                            //                 onPressed: () {
                            //                   _authHandler
                            //                       .newUserEmailPassword(
                            //                     email: _emailCtrl.text,
                            //                     password: _passwordCtrl.text,
                            //                   )
                            //                       .then(
                            //                     (done) {
                            //                       _authHandler
                            //                           .signInWithEmailPassword(
                            //                         email: _emailCtrl.text,
                            //                         password:
                            //                             _passwordCtrl.text,
                            //                           );
                            //                       // 
                            //                     },
                            //                   );
                            //                 },
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }
                          }),
                    ],
                  )
                : Text("")
          ],
        ),
      ),
    );
  }
}
