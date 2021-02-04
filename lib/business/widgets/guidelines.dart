import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_check_in/business/add_room.dart';

TextEditingController _guideLinesCtrl = TextEditingController();

class Guidelines extends HookWidget {
  final TextStyle _subTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _entries = useProvider(entriesProvider);
    return SingleChildScrollView(
      child: Container(
        color: Colors.green.shade200,
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: TextField(
                controller: _guideLinesCtrl,
                onSubmitted: (value) {
                  _entries.addGuideline(newGuideline: _guideLinesCtrl.text);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  labelText: "Add guidelines",
                  hintText: "e.g: Wash hands before entering",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${_entries.guidelinesList.length} guidelines to follow",
                        style: _subTitleStyle,
                      ),
                    ],
                  ),
                  _entries.guidelinesList.length != 0
                      ? Card(
                          child: Container(
                            height: _size.height / 1 / 4,
                            width: _size.width,
                            child: ListView.builder(
                              itemCount: _entries.guidelinesList.length,
                              itemBuilder: (_, int index) {
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Text("$index"),
                                        ),
                                        title: Text(
                                          "${_entries.guidelinesList[index]}",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
