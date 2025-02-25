import 'package:app_nghe_nhac/controller/add_song_dialog.dart';
import 'package:app_nghe_nhac/controller/playlist_provider.dart';
import 'package:app_nghe_nhac/view/widgetsForBaiHat/Songs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistTitle;

  const PlaylistDetailScreen({Key? key, required this.playlistTitle}) : super(key: key);

  @override
  _PlaylistDetailScreenState createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {

  @override
  Widget build(BuildContext context) {
    var playlistProvider= Provider.of<PlaylistProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlistTitle),
        backgroundColor: Colors.teal,
      ),
      body: playlistProvider.getSongsFromPlaylist(widget.playlistTitle).isEmpty
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  // Thêm bài hát vào playlist
                  showAddSongDialog(context, widget.playlistTitle);
                },
                child: Text("Thêm bài hát"),
              ),
            )
          : ListView.builder(
              itemCount: playlistProvider.getSongsFromPlaylist(widget.playlistTitle).length,
              itemBuilder: (context, index) {
                return Songs(
                      title: playlistProvider.getSongsFromPlaylist(widget.playlistTitle)[index]['title']!,
                      ngheSi: playlistProvider.getSongsFromPlaylist(widget.playlistTitle)[index]['ngheSi']??'Không rõ nghệ sĩ',  
                      onMorePressed: () {
                        //print("Nhấn vào nút more");
                      },
                      onTap: () {
                        // Phát bài hát
                      },
                    );
              },
            ),
    );
  }
}
