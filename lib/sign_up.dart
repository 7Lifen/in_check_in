// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:in_check_in/handlers/auth.dart';
// import 'package:in_check_in/helper/input/textfield_template.dart';
// import 'package:in_check_in/helper/output/box_animator.dart';

// GlobalKey<ScaffoldState> _signUpScaffoldKey =
//     new GlobalKey<ScaffoldState>(debugLabel: "SignUpView");

// // ignore: must_be_immutable
// class AddUserView extends HookWidget {
//   final String adminId;
//   TextEditingController _emailCtrl = TextEditingController();
//   TextEditingController _passwordCtrl = TextEditingController();
//   TextEditingController _confirmPasswordCtrl = TextEditingController();
//   FocusNode _confirmPasswordNode = FocusNode();
//   bool _showPassword = false;
//   bool _showConfPassword = false;
//   bool _showButton = false;

//   AddUserView({this.adminId});

//   @override
//   Widget build(BuildContext context) {
//     final _change = useState<bool>(false);
//     final _user = useProvider(userProvider);

//     final AuthHandler _authHandler = AuthHandler();
//     Size _size = MediaQuery.of(context).size;
//     return Scaffold(
//       key: _signUpScaffoldKey,
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             }),
//         backgroundColor: Colors.black,
//         title: Text("Sign-Up"),
//         centerTitle: true,
//       ),
//       body: Container(
//         height: _size.height,
//         width: _size.width,
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 13,
//             ),
//             Center(
//               child: Box(
//                 delay: 500,
//                 string: false,
//                 widget: Container(
//                   height: _size.height / 11,
//                   width: _size.width / 1.3,
//                   child: TextfieldTemplate(
//                     showSuffixIcon: false,
//                     doNext: () {
//                       _showPassword = true;
//                       _change.value = !_change.value;
//                     },
//                     size: _size,
//                     ctrl: _emailCtrl,
//                     nextNode: FocusNode(),
//                     hintText: "Enter your email",
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 7,
//             ),
//             _showPassword
//                 ? Center(
//                     child: Box(
//                       delay: 400,
//                       string: false,
//                       widget: Center(
//                         child: TextfieldTemplate(
//                           showSuffixIcon: true,
//                           doNext: () {
//                             _showConfPassword = true;
//                             _change.value = !_change.value;
//                           },
//                           size: _size,
//                           nextNode: _confirmPasswordNode,
//                           ctrl: _passwordCtrl,
//                           hintText: "Enter your password",
//                         ),
//                       ),
//                     ),
//                   )
//                 : Text(""),
//             SizedBox(
//               height: 7,
//             ),
//             _showConfPassword
//                 ? Center(
//                     child: Box(
//                       delay: 400,
//                       string: false,
//                       widget: Center(
//                         child: TextfieldTemplate(
//                           doNext: () {
//                             _showButton = true;
//                             _change.value = !_change.value;
//                           },
//                           showSuffixIcon: true,
//                           size: _size,
//                           ctrl: _confirmPasswordCtrl,
//                           focusNode: _confirmPasswordNode,
//                           nextNode: FocusNode(),
//                           hintText: "Confirm your password",
//                         ),
//                       ),
//                     ),
//                   )
//                 : Text(""),
//             SizedBox(
//               height: 30,
//             ),
//             _showButton
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       RawMaterialButton(
//                         fillColor: Colors.lightGreen,
//                         elevation: 15,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(30),
//                           ),
//                         ),
//                         child: Text(
//                           "Sign-Up",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () {
//                           print("ADMINID: $adminId");
//                           bool _showDialog = true;
//                           _showDialog
//                               ? showDialog(
//                                   context: context,
//                                   builder: (_) {
//                                     return AlertDialog(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(
//                                             (20),
//                                           ),
//                                         ),
//                                       ),
//                                       insetPadding: EdgeInsets.all(1),
//                                       contentPadding: EdgeInsets.all(1),
//                                       title: Center(child: Text("Loading...")),
//                                       content: Container(
//                                         height: _size.height / 3,
//                                         width: _size.width / 1.2,
//                                         child: Center(
//                                             child: CircularProgressIndicator()),
//                                       ),
//                                     );
//                                   })
//                               : print("");

//                           _authHandler
//                               .newUserEmailPassword(
//                                   email: _emailCtrl.text.trim(),
//                                   password: _passwordCtrl.text.trim())
//                               .then(
//                             (firebaseUser) async {
//                               _user.firstName = _accountUser.firstName;
//                               _user.lastName = _accountUser.lastName;
//                               print("FirebaseUser: $firebaseUser");
//                               _user.userId = firebaseUser.uid;
//                               _user.userEmail = firebaseUser.email;
//                               _user.accountId = adminId == "null"
//                                   ? firebaseUser.uid
//                                   : adminId;
//                               _user.status = _user.accountId == "null"
//                                   ? "Active"
//                                   : "Inactive";
//                               _user.accountId == "null"
//                                   ? _user.access = {
//                                       "DashBoard": [_create, _read, _update],
//                                       "Time": [_create, _read, _update],
//                                       "Energy": [_create, _read, _update],
//                                       "Accounting": [_create, _read, _update],
//                                       "Management": [_create, _read, _update],
//                                       "Chat": [_create, _read],
//                                       "Announcement": [_create, _read],
//                                       "Invoices": [
//                                         _create,
//                                         _read,
//                                         _update,
//                                         _delete
//                                       ],
//                                       "Expenses": [_create, _read, _delete],
//                                       "Tools": [
//                                         _create,
//                                         _read,
//                                         _update,
//                                         _delete
//                                       ],
//                                       "Training": [
//                                         _create,
//                                         _read,
//                                         _update,
//                                         _delete
//                                       ],
//                                       "Settings": [_read, _update],
//                                     }
//                                   : _user.access = {
//                                       "DashBoard": [],
//                                       "Time": [],
//                                       "Energy": [],
//                                       "Accounting": [],
//                                       "Management": [],
//                                       "Chat": [],
//                                       "Announcement": [],
//                                       "Invoices": [],
//                                       "Expenses": [],
//                                       "Tools": [],
//                                       "Training": [],
//                                       "Settings": [],
//                                     };
//                               _user.photoUrl = firebaseUser.photoUrl;

//                               _accountUser.photoURL = firebaseUser.photoURL;
//                               _accountUser.userUid = firebaseUser.uid;
//                               _accountUser.adminUid = adminId == "null"
//                                   ? firebaseUser.uid
//                                   : adminId;
//                               _accountUser.email = firebaseUser.email;
//                               _accountUser.creationTime =
//                                   "${DateTime.now().toString()}";
//                               _accountUser.employeesCount = "1";
//                               final DatabasePaths _path =
//                                   DatabasePaths(user: _user);

//                               var _dbPath = _path.managementFiresPath(
//                                 setRootPath: true,
//                               );
//                               _dbPath.set({
//                                 "${_accountUser.userUid}": _accountUser.toMap(),
//                               }, SetOptions(merge: true)).whenComplete(
//                                 () {
//                                   _path
//                                       .userRtdPath()
//                                       .child("${_user.userId}")
//                                       .set(_user.toMap());
//                                   _showDialog = false;
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (_) => App(),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   )
//                 : Text(""),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SigningDialog extends HookWidget {
//   final String userEmail;
//   // final DatabasePaths _path = DatabasePaths();

//   SigningDialog({Key key, this.userEmail}) : super(key: key);
//   Widget build(BuildContext context) {
//     final _path = useProvider(databasePaths);
//     return AlertDialog(
//       content: StreamBuilder<Event>(
//         stream: _path.userRtdStream(child: "UserEmail", equalTo: userEmail),
//         builder: (_, AsyncSnapshot<Event> snapshot) {
//           if (snapshot.hasData && snapshot.data.snapshot != null) {
//             return Center(
//               child: Text("Data found ${snapshot.data.snapshot}"),
//             );
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
