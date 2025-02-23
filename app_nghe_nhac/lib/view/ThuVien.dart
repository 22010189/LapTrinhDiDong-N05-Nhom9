import 'package:app_nghe_nhac/view/AnBaiHat.dart';
import 'package:app_nghe_nhac/view/NgheGanDay.dart';
import 'package:app_nghe_nhac/view/BaiHat.dart';
import 'package:app_nghe_nhac/view/YeuThich.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/more_options.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/option_card.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/playlist_item.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/recent_card.dart';
import 'package:flutter/material.dart';
import 'package:app_nghe_nhac/controller/navigation_controller.dart';

ValueNotifier<String> recentPlaylist =
    ValueNotifier<String>(''); // Lưu trữ tên playlist gần đây nhất đã bấm vào

class ThuVien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
        elevation: 0,
        title: Text(
          'Thư viện',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => showMoreOptions(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OptionCard(
                    icon: Icons.favorite,
                    title: 'Yêu thích',
                    count: ' ',
                    color: Colors.blue,
                    onTap: () => NavigationController.navigateTo(
                        context, YeuThich())), //màn hình yêu thích
                SizedBox(width: 10),
                OptionCard(
                    icon: Icons.download,
                    title: 'Đã tải',
                    count: ' ',
                    color: Colors.purple,
                    onTap: () => NavigationController.navigateTo(
                        context, BaiHat())), //giao diện đã tải
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: OptionCard(
                      icon: Icons.album,
                      title: 'Album',
                      count: '',
                      color: Colors.pink,
                      onTap: () => NavigationController.navigateTo(context,
                          Placeholder())), // bỏ qua k code giao diện này
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16, left: 10),
                  child: OptionCard(
                      icon: Icons.visibility_off,
                      title: 'Ẩn',
                      count: '',
                      color: const Color.fromARGB(255, 252, 252, 0),
                      onTap: () => NavigationController.navigateTo(
                          context, AnBaiHat())), //giao diện ẩn bài hát
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Nghe gần đây',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 16),
                RecentCard(
                    title: 'Bài Hát Nghe Gần Đây',
                    icon: Icons.history,
                    onTap: () => NavigationController.navigateTo(context,
                        NgheGanDay())), //giao diện bài hát nghe gần đây
                ValueListenableBuilder<String>(
                  valueListenable: recentPlaylist,
                  builder: (context, value, child) {
                    return RecentCard(
                      title: value.isEmpty
                          ? 'Gần đây chưa nghe playlist nào'
                          : value,
                      icon: Icons.music_note,
                      onTap: () => NavigationController.navigateTo(
                          context, Placeholder()),
                    );
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Playlist',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ThuVien2(),
          ),
        ],
      ),
    );
  }
}

class ThuVien2 extends StatefulWidget {
  @override
  State<ThuVien2> createState() => ThuVien2State();
}

class ThuVien2State extends State<ThuVien2> {
  List<Map<String, String>> playlists = [];

  // Hàm hiển thị hộp thoại nhập Playlist
  void showCreatePlaylistDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController subtitleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tạo Playlist"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Tên Playlist"),
              ),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: "Mô tả"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng hộp thoại
              },
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    playlists.add({
                      'title': nameController.text,
                      'subtitle': subtitleController.text,
                      'icon': 'music_note',
                    });
                  });
                }

                Navigator.pop(context); // Đóng hộp thoại
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Hàm hiện playlist nghe gần nhất
  void updateRecentPlaylist(String newPlaylist) {
    recentPlaylist.value = newPlaylist;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Danh sách playlist
        Container(
          height: 180,
          child: ListView.builder(
            itemCount: playlists.length + 1, // +1 để có thêm nút "Tạo playlist"
            itemBuilder: (context, index) {
              if (index == 0) {
                // Nút tạo playlist
                return PlaylistItem(
                  title: 'Tạo playlist',
                  subtitle: 'New',
                  icon: Icons.add,
                  onTap: () => showCreatePlaylistDialog(context),
                );
              } else {
                // Hiển thị playlist từ danh sách
                var playlist = playlists[index -
                    1]; // Lùi 1 index vì phần tử đầu tiên là "Tạo playlist"
                return PlaylistItem(
                  title: playlist['title']!,
                  subtitle: playlist['subtitle']!,
                  icon: Icons.music_note,
                  onTap: () {
                    updateRecentPlaylist(playlist['title']!);
                    // Chuyển sang màn hình Playlist nếu cần
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
