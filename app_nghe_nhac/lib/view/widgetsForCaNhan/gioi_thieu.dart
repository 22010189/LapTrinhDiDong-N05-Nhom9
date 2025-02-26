import 'package:flutter/material.dart';

class GioiThieuAppScreen extends StatelessWidget {
  const GioiThieuAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu ứng dụng"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🔹 Tác giả",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
                "Ứng dụng được phát triển bởi [Nhóm 9], với mong muốn mang đến trải nghiệm nghe nhạc mượt mà, tiện lợi và cá nhân hóa cho người dùng."),
            SizedBox(height: 10),
            Text("🔹 Ngôn ngữ & Công nghệ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
                "Ứng dụng được viết bằng Flutter – một framework đa nền tảng mạnh mẽ của Google, sử dụng ngôn ngữ Dart."),
            Text("Hỗ trợ chạy trên cả Android và iOS."),
            SizedBox(height: 10),
            Text("🔹 Mô tả ứng dụng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
                "Ứng dụng nghe nhạc cục bộ giúp bạn quản lý và phát nhạc trực tiếp từ thiết bị của mình mà không cần kết nối Internet."),
            Text("✅ Giao diện đẹp, trực quan, hỗ trợ chế độ sáng & tối."),
            Text(
                "✅ Quản lý danh sách phát nhạc, sắp xếp bài hát theo thư mục, nghệ sĩ, album."),
            Text("✅ Tùy chỉnh giao diện theo sở thích cá nhân."),
            Text(
                "✅ Bộ điều khiển nhạc tiện lợi: phát/tạm dừng, tua nhanh, lặp lại, xáo trộn."),
            Text("✅ Hiển thị lời bài hát, giúp bạn hát theo dễ dàng."),
          ],
        ),
      ),
    );
  }
}
