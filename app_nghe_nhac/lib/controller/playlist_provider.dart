import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlaylistProvider with ChangeNotifier {
  Map<String, List<Map<String, String>>> playlists = {}; // Lưu danh sách bài hát theo playlist

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userId = "user_456";


  void addSongToPlaylist(String playlistTitle, Map<String, String> song) {
    playlists.putIfAbsent(playlistTitle, () => []);
    
    // Kiểm tra bài hát đã tồn tại chưa
    if (!playlists[playlistTitle]!.any((s) => s['url'] == song['url'])) {
      playlists[playlistTitle]!.add(song);
      savePlaylists();
      notifyListeners();
    }
  }

  void removeSongFromPlaylist(String playlistTitle, Map<String, String> song) {
    playlists[playlistTitle]?.remove(song);
    savePlaylists();
    notifyListeners();
  }

  List<Map<String, String>> getSongsFromPlaylist(String playlistTitle) {
    return playlists[playlistTitle] ?? [];
  }

  Future<void> savePlaylists() async {
    await _firestore.collection('users').doc(userId).set({
      'playlists': playlists.map((key, value) => MapEntry(
            key,
            value.map((song) => song['url']).toList(), // Chỉ lưu URL bài hát
          )),
    }, SetOptions(merge: true)); // Tránh ghi đè dữ liệu khác
  }

  Future<void> loadPlaylists(List<Map<String, String>> allSongs) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc['playlists'] ?? {};
      playlists = data.map((key, songUrls) {
        return MapEntry(
          key,
          allSongs.where((song) => songUrls.contains(song['url'])).toList(),
        );
      }).cast<String, List<Map<String, String>>>();
      notifyListeners();
    }
  }



}
