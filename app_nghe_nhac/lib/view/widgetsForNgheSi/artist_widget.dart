import 'package:flutter/material.dart';

class ArtistWidget extends StatelessWidget {
  final String artistName;
  final VoidCallback onMorePressed;
  final VoidCallback onTap;

  const ArtistWidget({
    Key? key,
    required this.artistName,
    required this.onMorePressed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.teal[900], // Màu nền đậm hơn
        borderRadius: BorderRadius.circular(8), // Bo góc
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[800], // Màu nền cho icon
            shape: BoxShape.circle, // Hình tròn
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 30),
        ),
        title: Text(
          artistName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: onMorePressed,
        ),
        onTap: onTap,
      ),
    );
  }
}
