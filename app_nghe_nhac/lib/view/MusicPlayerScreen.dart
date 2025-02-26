import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

//giao diện nghe nhạc chính
class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  AudioPlayer get _audioPlayer => SongProvider.audioPlayer;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;

  void initState() {
    super.initState();

    // Lắng nghe tiến trình bài hát
    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        //print("Thời gian hiện tại: ${position.inSeconds} giây");
        setState(() {
          _currentPosition = position;
        });
      }
    });

    // Lắng nghe tổng thời gian bài hát
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        //print("Tổng thời gian bài hát: ${duration.inSeconds} giây");
        setState(() {
          _totalDuration = duration;
        });
      }
    });
  }

  void toggleRepeatMode() {
    setState(() {
      SongProvider.repeatMode = (SongProvider.repeatMode + 1) % 3;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    var currentSong = songProvider.isPlayingFavorites
        ? songProvider.favoriteSongs[songProvider.currentIndex]
        : songProvider.songs[songProvider.currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 89, 103),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 135, 135),
        elevation: 0,
        title: Text(
          currentSong['title'] ?? 'Không có tiêu đề',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              //print("Nhấn vào nút ba chấm");
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ảnh bài hát
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                    'image/disc.jpg'), // Ảnh đĩa nhạc (disc.png)
                fit: BoxFit.cover, 
              ),
            ),
          ),
          SizedBox(height: 20),

          Text(
            currentSong['title'] ?? 'Không có tiêu đề',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            currentSong['ngheSi'] ?? 'Không rõ nghệ sĩ',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 20),

          Column(
            children: [
              Slider(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                min: 0,
                max: _totalDuration.inSeconds
                    .toDouble(), // Max = tổng thời gian bài hát
                value: _currentPosition.inSeconds.toDouble().clamp(
                    0, _totalDuration.inSeconds.toDouble()), // Giá trị hiện tại
                onChanged: (value) {
                  setState(() {
                    _currentPosition = Duration(seconds: value.toInt());
                  });
                },
                onChangeEnd: (value) async {
                  await _audioPlayer
                      .seek(Duration(seconds: value.toInt())); // Tua bài hát
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(
                          _currentPosition), // Hiển thị thời gian hiện tại
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      _formatDuration(
                          _totalDuration), // Hiển thị tổng thời gian bài hát
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  SongProvider.repeatMode == 0
                      ? Icons.repeat
                      : SongProvider.repeatMode == 1
                          ? Icons.repeat_one
                          : Icons.shuffle,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: toggleRepeatMode,
              ),
              SizedBox(width: 60),
              IconButton(
                icon: Icon(
                  songProvider.isFavorite(currentSong)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  songProvider.toggleFavorite(currentSong, context);
                  if (songProvider.isPlayingFavorites == true &&
                      songProvider.favoriteSongs.isEmpty) {
                    songProvider.playFromIndex(0);
                  } else if (songProvider.isPlayingFavorites == true &&
                      songProvider.songs.isNotEmpty) {
                    songProvider.nextSong();
                  }
                },
              ),
              SizedBox(width: 60),
              IconButton(
                icon: Icon(Icons.queue_music, color: Colors.white, size: 30),
                onPressed: () {
                  //print("Nhấn vào danh sách phát");
                },
              ),
            ],
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white, size: 40),
                onPressed: () {
                  songProvider.previousSong();
                },
              ),
              IconButton(
                icon: Icon(
                  songProvider.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: Colors.white,
                  size: 60,
                ),
                onPressed: () {
                  songProvider.playPause();
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.white, size: 40),
                onPressed: () {
                  songProvider.nextSong();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
