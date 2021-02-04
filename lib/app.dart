import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:in_check_in/business/business_page.dart';
import 'package:in_check_in/customer/customers_page.dart';
import 'package:in_check_in/intro/intro_page.dart';
import 'package:in_check_in/intro/loading_screen.dart';

import 'package:in_check_in/user_provider.dart';

final firebaseAuth = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

class App extends HookWidget {
  Widget build(BuildContext context) {
    final _firebaseAuth = useProvider(firebaseAuth);
    final _userProvider = useProvider(userProvider);
    // _userProvider.readType();
    print("USERID: ${_userProvider.uid}");
    print("USERTYPE: ${_userProvider.type}");
    String _userType = _userProvider.type;
    return StreamBuilder(
      stream: _firebaseAuth.authStateChanges(),
      builder: (context, AsyncSnapshot snapUser) {
        if (snapUser.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        if (snapUser.data != null) {
          print("SNAPUSER: ${snapUser.data}");
          _userProvider.changeUid(newUid: _firebaseAuth.currentUser.uid);

          if ("$_userType" == "B") {
            return BusinessPage();
          }
          if ("$_userType" == "C") {
            return CustomersPage();
          } else {
            return IntroPage();
          }
        } else {
          return IntroPage();
        }
      },
    );
  }
}
