import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'list_songs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// quản lý danh sách bài hát đã tải từ ListSongs
class SongProvider with ChangeNotifier {
  List<Map<String, String>> songs = [];
  List<Map<String, String>> favoriteSongs = [];
  List<Map<String, String>> currentPlaylist = [];

  int currentIndex = 0;
  static int repeatMode = 0; // 0: Lặp lại danh sách, 1: Lặp lại bài hát, 2: Phát ngẫu nhiên

  bool isPlaying = false;

  static final AudioPlayer audioPlayer = AudioPlayer();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userId = "user_123";

  void setPlaylist(String playlistName) {
    if (playlistName == 'favorites') {
      currentPlaylist = favoriteSongs;
    }else {
      currentPlaylist = songs; // Mặc định là danh sách tất cả bài hát
    }
    currentIndex = 0;
    notifyListeners();
  }

  Future<void> loadSongs() async {
    if (songs.isEmpty) {
      songs = await ListSongs.loadSongs();
      currentPlaylist = songs;
      await loadFavoriteSongs();
      notifyListeners();
    }
  }

  void playFromIndex(int index) async {
    if (currentPlaylist.isEmpty) return;
    currentIndex = index;
    await playNewSong();
  }

  void resumeSong() async {
    if (currentPlaylist.isEmpty) return;
    if (isPlaying) {
      await audioPlayer.pause();
      await audioPlayer.resume();
    }
    notifyListeners();
  }

  Future<void> playPause() async {
    if (currentPlaylist.isEmpty) return;

    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      PlayerState state = audioPlayer.state;
      if (state == PlayerState.paused) {
        await audioPlayer.resume();
      } else {
        await audioPlayer.play(AssetSource(
            currentPlaylist[currentIndex]['url']!.replaceFirst('assets/', '')));
      }
    }
    isPlaying = !isPlaying;
    notifyListeners(); // Cập nhật UI khi trạng thái thay đổi
  }

  void nextSong() async {
    if (currentPlaylist.isEmpty) return;
    if (repeatMode == 1) {
      await playNewSong();
    } else if (repeatMode == 2) {
      currentIndex = Random().nextInt(currentPlaylist.length);
    } else {
      currentIndex = (currentIndex + 1) % currentPlaylist.length;
    }
    await playNewSong();
  }

  void previousSong() async {
    if (currentPlaylist.isEmpty) return;
    currentIndex = (currentIndex - 1 + currentPlaylist.length) %  currentPlaylist.length;
    await playNewSong();
  }

  Future<void> playNewSong() async {
    if (currentPlaylist.isEmpty) return;
    await audioPlayer.stop();
    //print('Playing: ${songs[currentIndex]['url']}');
    await audioPlayer.play(
        AssetSource(currentPlaylist[currentIndex]['url']!.replaceFirst('assets/', '')));

    isPlaying = true;
    notifyListeners(); // Cập nhật UI khi trạng thái thay đổi
  }

  void toggleFavorite(Map<String, String> song, BuildContext context) {
    bool isAdded;
    if (favoriteSongs.contains(song)) {
      favoriteSongs.remove(song);
      isAdded = false;
    } else {
      favoriteSongs.add(song);
      isAdded = true;
    }
    saveFavoriteSongs();
    notifyListeners();

    // Hiển thị Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isAdded ? Colors.green : Colors.red,
        content: Text(
          isAdded ? "Đã thêm vào mục yêu thích" : "Đã xóa khỏi mục yêu thích",
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Giúp hiển thị nổi lên trên UI
      ),
    );
  }

  bool isFavorite(Map<String, String> song) {
    // Kiểm tra xem bài hát đã được thêm vào mục yêu thích chưa
    return favoriteSongs.contains(song);
  }

  Future<void> saveFavoriteSongs() async {
    await _firestore.collection('users').doc(userId).set({
      'favoriteSongs': favoriteSongs.map((song) => song['url']).toList(),
    });
  }

  Future<void> loadFavoriteSongs() async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      List<dynamic> songUrls = doc['favoriteSongs'] ?? [];
      favoriteSongs =
          songs.where((song) => songUrls.contains(song['url'])).toList();
      notifyListeners();
    }
  }
}
