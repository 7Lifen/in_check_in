import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String uid = '';
  String name = '';
  String email = '';
  String type = '';

  changeUid({String newUid}) {
    uid = newUid;
  }

  changeType({String newType}) async {
    final SharedPreferences prefs = await _prefs;
    type = newType;
    prefs.setString('Type', newType).then((bool success) {
      return newType;
    });

    notifyListeners();
  }

  readType() async {
    final SharedPreferences prefs = await _prefs;
    type = prefs.getString('type');
  }
}
