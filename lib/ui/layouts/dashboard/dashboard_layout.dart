import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/sidebar.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Row(
          children: [
            Sidebar(),
            Expanded(
              child: child,
            ),
          ],
        ));
  }
}
