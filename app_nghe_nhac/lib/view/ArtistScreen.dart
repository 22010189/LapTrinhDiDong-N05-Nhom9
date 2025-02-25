import 'package:app_nghe_nhac/controller/list_songs.dart';
import 'package:flutter/material.dart';
import 'package:app_nghe_nhac/view/widgetsForThuVien/more_options.dart';
import 'package:app_nghe_nhac/view/widgetsForNgheSi/artist_widget.dart';


class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  List<String> uniqueArtists = [];

  @override
  void initState() {
    super.initState();
    _loadArtists();
  }

  Future<void> _loadArtists() async {
    List<Map<String, String>> songs = await ListSongs.loadSongs();

    // Lọc danh sách nghệ sĩ không trùng lặp
    Set<String> artistSet = {};
    for (var song in songs) {
      if (song.containsKey('ngheSi') && song['ngheSi']!.isNotEmpty) {
        artistSet.add(song['ngheSi']!);
      }
    }

    setState(() {
      uniqueArtists = artistSet.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
        elevation: 0,
        title: const Text(
          'Nghệ sĩ',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => showMoreOptions(context),
          ),
        ],
      ),
      body: uniqueArtists.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: uniqueArtists.length,
              itemBuilder: (context, index) {
                return ArtistWidget(
                  artistName: uniqueArtists[index],
                  onTap: () {
                    print("Bấm vào nghệ sĩ: ${uniqueArtists[index]}");
                  },
                  onMorePressed: () {
                    print("Bấm vào nút ba chấm của nghệ sĩ: ${uniqueArtists[index]}");
                  },
                );
              },
            ),
    );
  }
}
