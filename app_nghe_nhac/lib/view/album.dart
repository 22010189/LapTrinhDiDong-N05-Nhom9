import 'package:flutter/material.dart';

class Album {
  final String title;
  final String assets;

  Album({required this.title, required this.assets});
}

class AlbumScreen extends StatelessWidget {
  final List<Album> albums = [
    Album(
        title: "Soobin Hoàng Sơn - đĩa đơn", assets: "assets/image/soobin.jpg"),
    Album(title: "Đen Vâu - đĩa đơn", assets: "assets/image/Den_Vau.jpg"),
    Album(title: "Vũ - đĩa đơn", assets: "assets/image/VU.jpg"),
    Album(title: "Đạt G - đĩa đơn", assets: "assets/image/dat_G.jpg"),
    Album(title: "J97 - đĩa đơn", assets: "assets/image/j97.jpg"),
    Album(title: "MCK - đĩa đơn", assets: "assets/image/MCK.jpg"),
  ];

  AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 79, 79),
      appBar: AppBar(
        title: Text("Albums", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 86, 84, 81),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: albums.length,
          itemBuilder: (context, index) {
            final album = albums[index];
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                // Thêm hành động khi bấm nút ở đây
                              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Bo góc toàn bộ hình ảnh
                      child: SizedBox(
                        width: double.infinity, // Mở rộng toàn bộ chiều ngang
                        child: AspectRatio(
                          aspectRatio: 2, // Đảm bảo hình vuông
                          child: Image.asset(
                            album.assets,
                            fit: BoxFit.cover,
                            alignment: Alignment
                                .topCenter, // Cắt lấy phần trên của ảnh
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      album.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
