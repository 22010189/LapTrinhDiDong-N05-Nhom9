import 'package:app_nghe_nhac/view/widgetsForCaNhan/gioi_thieu.dart';
import 'package:flutter/material.dart';
import 'package:app_nghe_nhac/view/widgetsForCaNhan/giao_dien.dart';
import 'package:app_nghe_nhac/view/widgetsForCaNhan/ngon_ngu.dart';
import 'package:app_nghe_nhac/view/widgetsForCaNhan/thong_bao.dart';

// giao diện cá nhân
String _selectedLanguage = "Tiếng Việt";

class CaNhanScreen extends StatelessWidget {
  const CaNhanScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cá Nhân",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800], // Nền AppBar xám
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 6, 79, 79), // Nền xanh lá đậm
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar + Tên người dùng
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/image/user_avatar.png'),
            ),
            SizedBox(height: 10),
            Text(
              'Nhóm 9',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Ô chứa nút "Chỉnh sửa hồ sơ" & "Đăng xuất"
            Container(
              padding: EdgeInsets.all(16), 
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 6, 79, 79), // Nền ô tối hơn
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit,
                        color: const Color.fromARGB(255, 100, 91, 91)),
                    label: Text("Chỉnh sửa hồ sơ"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Danh sách các tùy chọn cài đặt
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title:
                        Text("Cài đặt", style: TextStyle(color: Colors.white)),
                    onTap: () {},
                  ),
                  Divider(color: Colors.white54),
                  ListTile(
                    leading: Icon(Icons.color_lens, color: Colors.white),
                    title: Text("Giao diện",
                        style: TextStyle(color: Colors.white)),
                    onTap: () => GiaoDienSelector.show(
                        context), // goi giao dien tu file new
                  ),
                  Divider(color: Colors.white54),
                  ListTile(
                      leading: Icon(Icons.language, color: Colors.white),
                      title: Text("Ngôn ngữ",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        NgonNguScreen.showLanguagePicker(context, (selected) {
                          _selectedLanguage = selected;
                        });
                      }),
                  Divider(color: Colors.white54),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.white),
                    title: Text("Thông báo",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TenManHinh()),
                      );
                    },
                  ),
                  Divider(color: Colors.white54),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.white),
                    title: Text("Giới thiệu ứng dụng",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GioiThieuAppScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
