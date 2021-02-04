import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_check_in/app.dart';
import 'package:in_check_in/business/add_room.dart';

class BusinessPage extends HookWidget {
  Widget build(BuildContext context) {
    final _userProvider = useProvider(userProvider);
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddRoom(),
              ),
            );
          }),
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        title: Center(
          child: Text("Virtual Rooms"),
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .reference()
              .child("${_userProvider.type}${_userProvider.uid}")
              .child("Rooms")
              .onValue,
          builder: (_, dataSnapshot) {
            if (dataSnapshot.hasData) {
              Event _data = dataSnapshot.data;
              List _keys = _data.snapshot.value.keys.toList();
              return ListView.builder(
                itemCount: _keys.length,
                itemBuilder: (_, int index) {
                  Map _dataIndex = _data.snapshot.value[_keys[index]];
                  return Card(
                    child: ListTile(
                      trailing: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Center(
                          child: Text(
                            "${_dataIndex["WaitingCount"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Center(
                          child: Text(
                            "$index",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      title: Text(
                        "${_dataIndex["RoomName"]}",
                      ),
                      subtitle: Text("${_dataIndex["Address"]}"),
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
