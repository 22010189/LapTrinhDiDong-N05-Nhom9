import 'package:flutter/material.dart';

class PlaylistProvider with ChangeNotifier {
  Map<String, List<Map<String, String>>> playlists = {}; // Lưu danh sách bài hát theo playlist

  void addSongToPlaylist(String playlistTitle, Map<String, String> song) {
    playlists.putIfAbsent(playlistTitle, () => []);
    
    // Kiểm tra bài hát đã tồn tại chưa
    if (!playlists[playlistTitle]!.any((s) => s['url'] == song['url'])) {
      playlists[playlistTitle]!.add(song);
      notifyListeners();
    }
  }

  void removeSongFromPlaylist(String playlistTitle, Map<String, String> song) {
    playlists[playlistTitle]?.remove(song);
    notifyListeners();
  }

  List<Map<String, String>> getSongsFromPlaylist(String playlistTitle) {
    return playlists[playlistTitle] ?? [];
  }
}
