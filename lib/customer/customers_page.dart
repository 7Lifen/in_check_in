import 'package:flutter/material.dart';
import 'package:in_check_in/app.dart';

class CustomersPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => App(),
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
          child: Text("Search for Available Virtual Rooms"),
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        child: StreamBuilder(
          builder: (_, dataSnapshot) {
            return Text("");
          },
        ),
      ),
    );
  }
}
