import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:app_nghe_nhac/controller/playlist_provider.dart';

void showAddSongDialog(BuildContext context, String playlistTitle) {
  List<Map<String, String>> allSongs = Provider.of<SongProvider>(context, listen: false).songs;
  PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  List<Map<String, String>> currentPlaylistSongs = playlistProvider.getSongsFromPlaylist(playlistTitle);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {  // Thêm StatefulBuilder để cập nhật UI
          return AlertDialog(
            title: Text("Thêm bài hát vào $playlistTitle"),
            content: Container(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: allSongs.length,
                itemBuilder: (context, index) {
                  final song = allSongs[index];
                  bool isInPlaylist = currentPlaylistSongs.any((s) => s['url'] == song['url']);

                  return ListTile(
                    title: Text(song['title']!),
                    subtitle: Text(song['ngheSi']!),
                    trailing: Icon(
                      isInPlaylist ? Icons.check_circle : Icons.add_circle,
                      color: isInPlaylist ? Colors.green : Colors.blue,
                    ),
                    onTap: () {
                      if (isInPlaylist) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Bài hát đã có trong playlist"),duration: Duration(seconds: 1),),
                        );
                      } else {
                        playlistProvider.addSongToPlaylist(playlistTitle, song);
                        setState(() {}); // Cập nhật UI ngay sau khi thêm bài hát
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Đã thêm vào playlist $playlistTitle"),duration: Duration(seconds: 1),),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Đóng dialog
                child: Text("Đóng"),
              ),
            ],
          );
        },
      );
    },
  );
}
