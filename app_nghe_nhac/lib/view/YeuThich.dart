import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/song_provider.dart';

class YeuThich extends StatelessWidget {
  const YeuThich({super.key});

  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài hát yêu thích"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: songProvider.favoriteSongs.isEmpty
          ? const Center(
              child: Text(
                "Chưa có bài hát yêu thích",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: songProvider.favoriteSongs.length,
              itemBuilder: (context, index) {
                var song = songProvider.favoriteSongs[index];
                return ListTile(
                  leading: const Icon(Icons.music_note, color: Colors.pink),
                  title: Text(
                    song['title'] ?? 'Không có tiêu đề',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(song['artist'] ?? 'Không rõ nghệ sĩ'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      songProvider.toggleFavorite(song,context);
                    },
                  ),
                  onTap: () {
                    songProvider.playFromIndex(songProvider.songs.indexOf(song));
                  },
                );
              },
            ),
    );
  }
}
