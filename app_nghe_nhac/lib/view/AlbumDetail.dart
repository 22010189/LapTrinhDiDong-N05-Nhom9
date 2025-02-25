import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:app_nghe_nhac/view/MusicPlayerScreen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:app_nghe_nhac/view/album.dart';
import 'package:app_nghe_nhac/controller/list_songs.dart';
import 'package:provider/provider.dart'; // Import file load danh sách bài hát

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
        iconTheme: const IconThemeData(color: Colors.white), // Đổi màu nút back
      ),
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh album với hiệu ứng mờ viền xung quanh
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    album.assets,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          // Box chứa tên album
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color.fromARGB(255, 0, 59, 59),
            child: Text(
              album.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Tiêu đề danh sách bài hát
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Danh sách bài hát:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Hiển thị danh sách bài hát của album
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: ListSongs.loadSongs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text("Lỗi khi tải danh sách bài hát",
                          style: TextStyle(color: Colors.white)));
                }

                List<Map<String, String>> filteredSongs = snapshot.data!
                    .where((song) => song['album'] == album.title)
                    .toList();

                // Thêm một bài hát mặc định nếu album không có bài hát nào
                if (filteredSongs.isEmpty) {
                  filteredSongs.add({
                    'title': 'Bài hát',
                    'url': 'https://example.com/default-song.mp3',
                    'album': album.title
                  });
                }

                return ListView.builder(
                  itemCount: filteredSongs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          const Icon(Icons.music_note, color: Colors.white),
                      title: Text(
                        filteredSongs[index]['title']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Xử lý phát nhạc
                        var songProvider =
                            Provider.of<SongProvider>(context, listen: false);

                        // Cập nhật bài hát đang phát
                        songProvider.setCurrentSong(filteredSongs, index);

                        // Phát bài hát
                        SongProvider.audioPlayer
                            .play(UrlSource(filteredSongs[index]['url']!));

                        // Chuyển đến giao diện nghe nhạc
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MusicPlayerScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
