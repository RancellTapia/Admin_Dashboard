import 'package:flutter/material.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Icon(
          Icons.notifications_none_outlined,
          color: Colors.grey,
        ),
        Positioned(
          right: 2,
          top: 2,
          child: Container(
            width: 8,
            height: 8,
            decoration: buildBoxDecoration(),
          ),
        )
      ],
    ));
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(10));
  }
}
