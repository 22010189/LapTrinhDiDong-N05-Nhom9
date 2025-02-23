import 'dart:convert';
import 'package:flutter/services.dart';

class ListSongs {

  static Future<List<Map<String, String>>> loadSongs() async {
    // Đọc danh sách file từ AssetManifest.json
    final String manifestContent =
        await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Lọc ra các file trong thư mục assets/song/
    List<String> songFiles = manifestMap.keys
        .where((key) => key.startsWith('assets/song/') && key.endsWith('.mp3'))
        .toList();

    // Tạo danh sách bài hát từ tên file
    List<Map<String, String>> songs = songFiles.map((filePath) {
      String fileName =
          filePath.split('/').last.replaceAll('.mp3', ''); // Lấy tên bài hát
      return {
        'title': fileName,
        'url': filePath,
        'image': 'assets/image/disc.jpg'
      };
    }).toList();

    print("Danh sách bài hát:");
    songs.forEach((song) {
      print(
          "Title: ${song['title']}, URL: ${song['url']}, Image: ${song['image']}");
    });

    return songs;
  }
}
