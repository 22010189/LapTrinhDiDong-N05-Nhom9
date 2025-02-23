import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const RecentCard({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: 140,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
