import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:in_check_in/app.dart';
import 'package:in_check_in/customer/customers_page.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:in_check_in/sign_in.dart';

class UserSelection extends HookWidget {
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _userProvider = useProvider(userProvider);
    return Container(
      width: _size.width,
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              fillColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                _userProvider.changeType(newType: "B");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SignInPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 13.0, bottom: 13.0, right: 1, left: 1),
                child: Text(
                  "A Service - Provider",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fillColor: Colors.red,
              onPressed: () {
                _userProvider.changeType(newType: "C");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CustomersPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 13.0, bottom: 13.0, right: 2, left: 2),
                child: Text(
                  "A Customer",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
