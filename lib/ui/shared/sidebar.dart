import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/widgets/logo.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          const Logo(),
          const SizedBox(height: 50),
          TextSeparator(text: 'Main'),
          MenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => print('Dashboard'),
          ),
          MenuItem(
            text: 'Orders',
            icon: Icons.shopping_cart_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Analytics',
            icon: Icons.show_chart_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Categories',
            icon: Icons.layers_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Products',
            icon: Icons.dashboard_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Discounts',
            icon: Icons.attach_money_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Customers',
            icon: Icons.people_alt_outlined,
            onPressed: () {},
          ),
          SizedBox(height: 30),
          TextSeparator(text: 'UI Elements'),
          MenuItem(
            text: 'Icons',
            icon: Icons.list_alt_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Marketing',
            icon: Icons.mark_email_read_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Campaigns',
            icon: Icons.note_add_outlined,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff092044),
          Color(0xff092042),
        ]),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10),
        ],
      );
}
