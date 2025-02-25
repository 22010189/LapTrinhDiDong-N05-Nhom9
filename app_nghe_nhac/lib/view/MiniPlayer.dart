import 'package:app_nghe_nhac/controller/navigation_controller.dart';
import 'package:app_nghe_nhac/controller/song_provider.dart';
import 'package:app_nghe_nhac/view/MusicPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    SongProvider.audioPlayer.onPlayerComplete.listen((event) {
      Provider.of<SongProvider>(context, listen: false).nextSong();
    });
  }

  @override
  void dispose() {
    SongProvider.audioPlayer.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        if (songProvider.songs.isEmpty) {
          return Container(
            color: const Color.fromARGB(255, 105, 105, 104),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Center(
              child: Text(
                "Không có bài hát",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        }
        if (songProvider.isPlaying) {
          rotationController.repeat();
        } else {
          rotationController.stop();
        }

        return GestureDetector(
          onTap: () {
            Provider.of<SongProvider>(context, listen: false).resumeSong();
            NavigationController.navigateTo(context, MusicPlayerScreen());
          },
          child: Container(
            color: const Color.fromARGB(255, 105, 105, 104),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                // Icon album xoay tròn
                AnimatedBuilder(
                  animation: rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationController.value * 2 * pi,
                      child: child,
                    );
                  },
                  child: ClipOval(
                    child: Image.asset(
                      'assets/image/disc.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Tên bài hát
                Expanded(
                  child: Text(
                    songProvider.isPlayingFavorites
                        ? songProvider.favoriteSongs[songProvider.currentIndex]
                            ['title']!
                        : songProvider.songs[songProvider.currentIndex]
                            ['title']!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Nút điều khiển
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.skip_previous, color: Colors.white),
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .previousSong();
                          rotationController.repeat();
                        }),
                    IconButton(
                        icon: Icon(
                          songProvider.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (songProvider.isPlaying) {
                            rotationController.stop();
                          } else {
                            rotationController.repeat();
                          }
                          Provider.of<SongProvider>(context, listen: false)
                              .playPause();
                        }),
                    IconButton(
                        icon: Icon(Icons.skip_next, color: Colors.white),
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .nextSong();
                          rotationController.repeat();
                        }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
