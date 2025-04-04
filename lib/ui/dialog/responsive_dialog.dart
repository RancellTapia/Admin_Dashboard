import 'package:flutter/material.dart';

class ResponsiveDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const ResponsiveDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final dialogWidth = screenWidth > 600 ? 600.0 : screenWidth * 0.9;
    final dialogHeight = screenHeight > 520 ? 520.0 : screenHeight * 0.9;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title,
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey[850]),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: SingleChildScrollView(
          child: content,
        ),
      ),
      actions: actions,
    );
  }
}
