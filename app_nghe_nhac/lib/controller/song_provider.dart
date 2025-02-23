import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'list_songs.dart';
// quản lý danh sách bài hát đã tải từ ListSongs
class SongProvider with ChangeNotifier {
  List<Map<String, String>> songs = [];
  int currentIndex = 0;
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
    await playPause();
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

    currentIndex = (currentIndex + 1) % songs.length;
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
    print('Playing: ${songs[currentIndex]['url']}');
    await audioPlayer.play(AssetSource(
        songs[currentIndex]['url']!.replaceFirst('assets/', '')));
    
    isPlaying = true;
    notifyListeners(); // Cập nhật UI
  }
}
