import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_check_in/business/add_room.dart';

TextEditingController _maxTimeCtrl = TextEditingController();
TextEditingController _maxListCtrl = TextEditingController();

class Restrictions extends HookWidget {
  final TextStyle _subTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  Widget build(BuildContext context) {
    final _entries = useProvider(entriesProvider);
    return SingleChildScrollView(
      child: Container(
        color: Colors.yellow,
        child: ExpansionTile(
          title: Card(
            child: Column(
              children: [
                Text(
                  "Allow check-In without a QR-Code",
                  style: _subTitleStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        _entries.changeCheckIn(newCheckInAway: false);
                      },
                      fillColor: _entries.checkInAway == false
                          ? Colors.red
                          : Colors.white,
                      child: Text("No"),
                    ),
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        _entries.changeCheckIn(newCheckInAway: true);
                      },
                      fillColor: _entries.checkInAway == true
                          ? Colors.green
                          : Colors.white,
                      child: Text("Yes"),
                    )
                  ],
                ),
              ],
            ),
          ),
          children: [
            Card(
              child: Column(
                children: [
                  Text(
                    "Maximum Time to Check-In",
                    style: _subTitleStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: TextField(
                        controller: _maxTimeCtrl,
                        onChanged: (value) {
                          _entries.changeMaxTime(newMaxTime: value);
                        },
                        decoration: InputDecoration(hintText: "e.g: 5:25 PM"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Text("Maximum Time to Check-In", style: _subTitleStyle),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: TextField(
                        controller: _maxListCtrl,
                        onChanged: (value) {
                          _entries.changeMaxTime(newMaxTime: value);
                        },
                        decoration:
                            InputDecoration(hintText: "e.g: 30 Patients"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
