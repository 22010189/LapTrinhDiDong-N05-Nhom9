import 'package:flutter/material.dart';

class Songs extends StatelessWidget {
  final String title;
  final String ngheSi;
  final VoidCallback onMorePressed;
  final VoidCallback onTap;

  const Songs({
    Key? key,
    required this.title,
    required this.ngheSi,
    required this.onMorePressed,
    required this.onTap,
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
          child: Icon(Icons.music_note, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          ngheSi,
          style: TextStyle(color: Colors.black87),
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
