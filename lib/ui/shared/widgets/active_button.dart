import 'package:flutter/material.dart';

class ActiveButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const ActiveButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xff092044),
            Color(0xff092042),
          ]),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
