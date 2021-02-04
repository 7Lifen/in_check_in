import 'package:flutter/material.dart';

class EntriesProvider extends ChangeNotifier {
  String roomName = "";
  String address = "";
  String phone = "";
  String email = "";
  bool checkInAway = true;
  String maxTime = "";
  String maxListLength = "";
  List guidelinesList = [];
  changeRoomName({String name = ''}) {
    roomName = name;
    notifyListeners();
  }

  changeAddress({String newAddress = ''}) {
    address = newAddress;
    notifyListeners();
  }

  changePhone({String newPhone = ''}) {
    phone = newPhone;
    notifyListeners();
  }

  changeEmail({String newEmail = ''}) {
    email = newEmail;
    notifyListeners();
  }

  changeCheckIn({bool newCheckInAway = true}) {
    checkInAway = newCheckInAway;
    notifyListeners();
  }

  changeMaxTime({String newMaxTime = ''}) {
    maxTime = newMaxTime;
    notifyListeners();
  }

  changeMaxListLength({String newListLength = ''}) {
    maxListLength = newListLength;
    notifyListeners();
  }

  addGuideline({String newGuideline = ''}) {
    guidelinesList.add(newGuideline);
    notifyListeners();
  }

  toMap() {
    return <String, dynamic>{
      "${DateTime.now().millisecondsSinceEpoch}": {
        "RoomName": "$roomName",
        "Address": "$address",
        "Phone": "$phone",
        "Email": "$email",
        "CheckInAway": "$checkInAway",
        "MaxTime": "$maxTime",
        "MaxListLength": "$maxListLength",
        "Guidelines": "$guidelinesList",
        "WaitingList": [],
        "WaitingCount": "0"
      }
    };
  }
}
