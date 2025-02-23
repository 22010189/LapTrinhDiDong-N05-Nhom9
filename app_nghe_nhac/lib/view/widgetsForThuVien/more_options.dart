import 'package:flutter/material.dart';

void showMoreOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.sort),
              title: Text("Sắp xếp theo"),
              onTap: () {
                Navigator.pop(context);
                print("Sắp xếp theo...");
              },
            ),
            ListTile(
              leading: Icon(Icons.library_music),
              title: Text("Quản lý bài hát"),
              onTap: () {
                Navigator.pop(context);
                print("Quản lý bài hát...");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Cài đặt"),
              onTap: () {
                Navigator.pop(context);
                print("Cài đặt...");
              },
            ),
          ],
        ),
      );
    },
  );
}
