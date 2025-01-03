import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:admin_dashboard/ui/shared/widgets/navbar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SideMenuProvider.menuController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= 700) Sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      NavBar(),
                      Expanded(
                        child: widget.child,
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (size.width < 700)
              AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (context, _) => Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(SideMenuProvider.movement.value, 0),
                            child: Sidebar(),
                          )
                        ],
                      ))
          ],
        ));
  }
}
