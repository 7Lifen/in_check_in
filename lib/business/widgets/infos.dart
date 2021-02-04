import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_check_in/business/add_room.dart';

TextEditingController _listNameCtrl = TextEditingController();
TextEditingController _addressCtrl = TextEditingController();
TextEditingController _phoneCtrl = TextEditingController();
TextEditingController _emailCtrl = TextEditingController();

class BusinessInfos extends HookWidget {
  Widget build(BuildContext context) {
    final _entries = useProvider(entriesProvider);
    return SingleChildScrollView(
      child: Container(
        color: Colors.red.shade200,
        child: ExpansionTile(
          initiallyExpanded: true,
          backgroundColor: Colors.red.shade200,
          childrenPadding: EdgeInsets.all(5),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: TextField(
                controller: _listNameCtrl,
                onChanged: (value) {
                  _entries.changeRoomName(name: value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  labelText: "Name of the waiting list",
                  hintText: "e.g: Dr Cure's Office",
                ),
              ),
            ),
          ),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 20,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: TextField(
                          controller: _addressCtrl,
                          onChanged: (value) {
                            _entries.changeAddress(newAddress: value);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            labelText: "Address",
                            hintText:
                                "e.g: 4380 Avenue de Lorimier, Montreal, H2H 2B2, Qc, Canada",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: TextField(
                          onChanged: (value) {
                            _entries.changePhone(newPhone: value);
                          },
                          controller: _phoneCtrl,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            contentPadding: EdgeInsets.only(left: 8),
                            hintText: "e.g: +819-333-4444",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: TextField(
                          controller: _emailCtrl,
                          onChanged: (value) {
                            _entries.changeEmail(newEmail: value);
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            contentPadding: EdgeInsets.only(left: 8),
                            hintText: "e.g: drcure@gmail.com",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
