import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const PlaylistItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white54),
      ),
      onTap: () => onTap(),
    );
  }
}
