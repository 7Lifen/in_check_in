import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_check_in/app.dart';
import 'package:in_check_in/business/business_page.dart';
import 'package:in_check_in/business/widgets/guidelines.dart';
import 'package:in_check_in/business/widgets/infos.dart';
import 'package:in_check_in/business/widgets/restrictions.dart';
import 'package:in_check_in/entries_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

final entriesProvider =
    ChangeNotifierProvider<EntriesProvider>((ref) => EntriesProvider());

class AddRoom extends HookWidget {
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _userProvider = useProvider(userProvider);
    final _entriesProvider = useProvider(entriesProvider);
    final TextStyle _titleStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.save,
          color: Colors.black,
        ),
        onPressed: () async {
          final _db = FirebaseDatabase.instance.reference();
          final _now = DateTime.now().millisecondsSinceEpoch;
          print("Type:${_userProvider.type}");
          print("UID: ${_userProvider.uid}");
          _db
              .child("${_userProvider.type}${_userProvider.uid}")
              .child("Rooms")
              .set(_entriesProvider.toMap());
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Center(
                  child: QrImage(
                    data: "$_now",
                  ),
                ),
                actions: [
                  RawMaterialButton(
                    elevation: 20,
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BusinessPage(),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          );
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
        ),
        height: _size.height,
        width: _size.width,
        child: Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Business Info",
                        style: _titleStyle,
                      ),
                    ],
                  ),
                  BusinessInfos(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Restrictions",
                        style: _titleStyle,
                      ),
                    ],
                  ),
                  Restrictions(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Guidelines",
                        style: _titleStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Text(
                          "",
                        ),
                        // "${_entries.guidelinesList.length}",
                        // style: _titleStyle,
                        // ),
                      )
                    ],
                  ),
                  Guidelines(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
