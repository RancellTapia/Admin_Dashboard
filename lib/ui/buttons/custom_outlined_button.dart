import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final bool isFilled;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        side: WidgetStateProperty.all(
          BorderSide(
            color: color,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          isFilled ? color.withValues(alpha: 0.3) : Colors.transparent,
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: color),
        ),
      ),
    );
  }
}
