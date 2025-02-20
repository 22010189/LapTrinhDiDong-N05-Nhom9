import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'list_songs.dart';

// quản lý danh sách bài hát đã tải từ ListSongs
class SongProvider with ChangeNotifier {
  List<Map<String, String>> songs = [];
  List<Map<String, String>> favoriteSongs = [];
  int currentIndex = 0;
  static int repeatMode = 0; // 0: Lặp lại danh sách, 1: Lặp lại bài hát, 2: Phát ngẫu nhiên
  bool isPlaying = false;
  static final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> loadSongs() async {
    if (songs.isEmpty) {
      songs = await ListSongs.loadSongs();
      notifyListeners();
    }
  }

  void playFromIndex(int index) async {
    if (songs.isEmpty) return;
    currentIndex = index;
    await playNewSong();
  }

  void resumeSong() async {
    if (songs.isEmpty) return;
    if (isPlaying) {
      await audioPlayer.pause();
      await audioPlayer.resume();
    }
    notifyListeners();
  }

  Future<void> playPause() async {
    if (songs.isEmpty) return;

    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      PlayerState state = audioPlayer.state;
      if (state == PlayerState.paused) {
        await audioPlayer.resume();
      } else {
        await audioPlayer.play(AssetSource(
            songs[currentIndex]['url']!.replaceFirst('assets/', '')));
      }
    }
    isPlaying = !isPlaying;
    notifyListeners(); // Cập nhật UI khi trạng thái thay đổi
  }

  void nextSong() async {
    if (songs.isEmpty) return;
    if (repeatMode == 1) {
      await playNewSong();
    } else if (repeatMode == 2) {
      currentIndex = Random().nextInt(songs.length);
    } else {
      currentIndex = (currentIndex + 1) % songs.length;
    }
    await playNewSong();
  }

  void previousSong() async {
    if (songs.isEmpty) return;

    currentIndex = (currentIndex - 1 + songs.length) % songs.length;
    await playNewSong();
  }

  Future<void> playNewSong() async {
    if (songs.isEmpty) return;

    await audioPlayer.stop();
    //print('Playing: ${songs[currentIndex]['url']}');
    await audioPlayer.play(AssetSource(songs[currentIndex]['url']!.replaceFirst('assets/', '')));

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
    return favoriteSongs.contains(song);
  }
}
