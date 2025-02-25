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
      String fileName = filePath.split('/').last.replaceAll('.mp3', ''); // Lấy tên bài hát
      String title;
      String artist;

      if (fileName.contains('_')) {
        // Tách theo dấu gạch dưới, phần đầu tiên là title, phần còn lại là artist
        List<String> parts = fileName.split('_'); 
        if (parts.length >= 2) { 
          title = parts[0]; 
          // Nối lại phần còn lại thành tên nghệ sĩ (nếu có nhiều dấu gạch dưới)
          artist = parts.sublist(1).join('_'); 
        } else {
          title = fileName;
          artist = "Không rõ nghệ sĩ";
        }
      } else {
        // Nếu không theo định dạng, dùng toàn bộ tên file làm title và artist mặc định
        title = fileName;
        artist = "Không rõ nghệ sĩ";
      }

      return {
        'title': title,
        'ngheSi': artist,
        'url': filePath,
        'image': 'assets/image/disc.jpg'
      };
    }).toList();
    /*
    print("Danh sách bài hát:");
    songs.forEach((song) {
      print(
          "Title: ${song['title']}, URL: ${song['url']}, Image: ${song['image']}");
    });
    */
    return songs;
  }
}
