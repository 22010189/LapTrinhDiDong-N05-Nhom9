import 'package:flutter/material.dart';
import 'package:app_nghe_nhac/controller/navigation_controller.dart';
import 'package:app_nghe_nhac/view/AnBaiHat.dart';
import 'package:app_nghe_nhac/view/BaiHat.dart';
import 'package:app_nghe_nhac/view/NgheGanDay.dart';
import 'package:app_nghe_nhac/view/PlaylistDetailScreen.dart';
import 'package:app_nghe_nhac/view/YeuThich.dart';
import 'package:app_nghe_nhac/view/album.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/more_options.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/option_card.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/playlist_item.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/recent_card.dart';

class ThuVien extends StatefulWidget {
  const ThuVien({super.key});

  @override
  State<ThuVien> createState() => _ThuVienState();
}

class _ThuVienState extends State<ThuVien> {
  final ValueNotifier<String> recentPlaylist = ValueNotifier<String>('');
  final List<Map<String, String>> playlists = [];

  // Hiển thị hộp thoại tạo playlist
  void _showCreatePlaylistDialog(BuildContext context) {
    final nameController = TextEditingController();
    final subtitleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tạo Playlist"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Tên Playlist")),
            TextField(controller: subtitleController, decoration: const InputDecoration(labelText: "Mô tả")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  playlists.add({
                    'title': nameController.text,
                    'subtitle': subtitleController.text,
                  });
                });
              }
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _updateRecentPlaylist(String newPlaylist) {
    recentPlaylist.value = newPlaylist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
        elevation: 0,
        title: const Text('Thư viện', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () => showMoreOptions(context)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOptionCards(context),
          _buildSectionTitle("Nghe gần đây"),
          _buildRecentList(),
          _buildSectionTitle("Playlist"),
          _buildPlaylistList(),
        ],
      ),
    );
  }

  Widget _buildOptionCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          OptionCard(icon: Icons.favorite, title: 'Yêu thích', color: Colors.blue, onTap: () => NavigationController.navigateTo(context, YeuThich()), count: '',),
          const SizedBox(width: 10),
          OptionCard(icon: Icons.download, title: 'Đã tải', color: Colors.purple, onTap: () => NavigationController.navigateTo(context, BaiHat()), count: '',),
          const SizedBox(width: 10),
          OptionCard(icon: Icons.album, title: 'Album', color: Colors.pink, onTap: () => NavigationController.navigateTo(context, AlbumScreen()), count: '',),
          const SizedBox(width: 10),
          OptionCard(icon: Icons.visibility_off, title: 'Ẩn', color: Colors.yellow, onTap: () => NavigationController.navigateTo(context, AnBaiHat()), count: '',),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRecentList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 16),
          RecentCard(title: 'Bài Hát Nghe Gần Đây', icon: Icons.history, onTap: () => NavigationController.navigateTo(context, NgheGanDay())),
          ValueListenableBuilder<String>(
            valueListenable: recentPlaylist,
            builder: (context, value, child) => RecentCard(
              title: value.isEmpty ? 'Gần đây chưa nghe playlist nào' : value,
              icon: Icons.music_note,
              onTap: () => NavigationController.navigateTo(context, PlaylistDetailScreen(playlistTitle: value)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistList() {
    return Expanded(
      child: ListView.builder(
        itemCount: playlists.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return PlaylistItem(
              title: 'Tạo playlist',
              subtitle: 'New',
              icon: Icons.add,
              onTap: () => _showCreatePlaylistDialog(context),
            );
          } else {
            final playlist = playlists[index - 1];
            return PlaylistItem(
              title: playlist['title']!,
              subtitle: playlist['subtitle']!,
              icon: Icons.music_note,
              onTap: () {
                _updateRecentPlaylist(playlist['title']!);
                NavigationController.navigateTo(context, PlaylistDetailScreen(playlistTitle: playlist['title']!));
              },
            );
          }
        },
      ),
    );
  }
}
