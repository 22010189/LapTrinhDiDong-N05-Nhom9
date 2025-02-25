import 'package:flutter/material.dart';

class Songs extends StatelessWidget {
  final String title;
  final String ngheSi;
  final VoidCallback onMorePressed;
  final VoidCallback onTap;
  final bool isFavorite;

  const Songs({
    Key? key,
    required this.title,
    required this.ngheSi,
    required this.onMorePressed,
    required this.onTap,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 6, 79, 79),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(isFavorite ? Icons.favorite : Icons.music_note, color: const Color.fromARGB(255, 224, 100, 121)),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          ngheSi,
          style: TextStyle(color: const Color.fromARGB(221, 255, 255, 255), fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onPressed: onMorePressed,
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
