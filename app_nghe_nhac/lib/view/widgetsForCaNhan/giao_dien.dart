import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:app_nghe_nhac/view/widgetsForCaNhan/theme_provider.dart";

class GiaoDienSelector { 
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.grey[900],
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Chọn giao diện",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.light_mode, color: Colors.yellow),
                title: Text("Sáng", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.dark_mode, color: Colors.white),
                title: Text("Tối", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_auto, color: Colors.blue),
                title: Text("Tự động", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
