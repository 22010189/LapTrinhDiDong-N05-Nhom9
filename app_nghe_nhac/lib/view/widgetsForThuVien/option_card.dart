import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final Color color;
  final VoidCallback onTap;

  const OptionCard({
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 33, 34, 33),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
          if (count.isNotEmpty)
            Text(count, style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
