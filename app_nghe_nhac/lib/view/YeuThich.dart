import 'package:app_nghe_nhac/controller/navigation_controller.dart';
import 'package:app_nghe_nhac/view/MusicPlayerScreen.dart';
import 'package:app_nghe_nhac/view/widgetsForBaiHat/Songs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/song_provider.dart';

class YeuThich extends StatelessWidget {
  const YeuThich({super.key});

  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        title: const Text("Bài hát yêu thích",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
      ),
      body: songProvider.favoriteSongs.isEmpty
          ? const Center(
              child: Text(
                "Chưa có bài hát yêu thích",
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (songProvider.favoriteSongs.isNotEmpty) {
                            songProvider.playFromIndex(0,
                                fromFavorites: true);
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.play_arrow,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 33),
                            const SizedBox(width: 8),
                            const Text(
                              'Phát tất cả',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${songProvider.favoriteSongs.length} bài hát',
                        style: const TextStyle(
                            color: Color.fromARGB(179, 255, 255, 255),
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: songProvider.favoriteSongs.length,
                    itemBuilder: (context, index) {
                      return Songs(
                        title: songProvider.favoriteSongs[index]['title']!,
                        ngheSi: songProvider.favoriteSongs[index]['ngheSi']??'Không rõ nghệ sĩ',
                        isFavorite: true,
                        onMorePressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.delete, color: Colors.red),
                                      title: const Text("Xóa khỏi yêu thích"),
                                      onTap: () {
                                        Provider.of<SongProvider>(context,listen: false).toggleFavorite( songProvider.favoriteSongs[index],context);
                                        if (songProvider.favoriteSongs.isEmpty && songProvider.isPlayingFavorites==true) {
                                          songProvider.playFromIndex(0);
                                        }
                                        Navigator.pop(context); // Đóng menu sau khi chọn
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        onTap: () {
                          Provider.of<SongProvider>(context, listen: false).playFromIndex(index,fromFavorites: true);
                          NavigationController.navigateTo(
                              context, MusicPlayerScreen());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
