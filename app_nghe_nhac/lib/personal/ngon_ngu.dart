import 'package:flutter/material.dart';

class NgonNguScreen {
  static void showLanguagePicker(
      BuildContext context, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900], // Màu nền tối
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Chọn ngôn ngữ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Divider(color: Colors.white54),
              _languageOption(context, "Tiếng Việt", onSelected),
              _languageOption(context, "English", onSelected),
              _languageOption(context, "Français", onSelected),
              _languageOption(context, "Español", onSelected),
              _languageOption(context, "日本語", onSelected),
            ],
          ),
        );
      },
    );
  }

  static Widget _languageOption(
      BuildContext context, String language, Function(String) onSelected) {
    return ListTile(
      title: Text(language, style: TextStyle(color: Colors.white)),
      onTap: () {
        onSelected(language);
        Navigator.pop(context); // Đóng hộp thoại
      },
    );
  }
}
