import 'package:app_nghe_nhac/controller/add_song_dialog.dart';
import 'package:app_nghe_nhac/controller/playlist_provider.dart';
import 'package:app_nghe_nhac/view/widgetsForBaiHat/Songs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistTitle;

  const PlaylistDetailScreen({Key? key, required this.playlistTitle})
      : super(key: key);

  @override
  _PlaylistDetailScreenState createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        title:
            Text(widget.playlistTitle, style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
        actions: [
          Consumer<PlaylistProvider>(
            builder: (context, playlistProvider, child) {
              int songCount = playlistProvider
                  .getSongsFromPlaylist(widget.playlistTitle)
                  .length;
              return Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    songCount > 0 ? "$songCount bài hát" : "",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          List<Map<String, String>> songs =
              playlistProvider.getSongsFromPlaylist(widget.playlistTitle);

          if (songs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chưa có bài hát nào",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showAddSongDialog(context, widget.playlistTitle);
                    },
                    child: Text("Thêm bài hát"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: songs.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  leading: Icon(Icons.playlist_add,
                      color: Colors.blue), // Thay đổi icon
                  title: Text(
                    "Thêm bài hát",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),
                  ),
                  onTap: () {
                    showAddSongDialog(context, widget.playlistTitle);
                  },
                );
              }
              return Songs(
                title: songs[index-1]['title']!,
                ngheSi: songs[index-1]['ngheSi'] ?? 'Không rõ nghệ sĩ',
                onMorePressed: () {},
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
