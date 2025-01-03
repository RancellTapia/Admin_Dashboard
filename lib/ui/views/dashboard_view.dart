import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Text('Dashboard View', style: CustomLabels.h1),
        SizedBox(height: 10),
        WhiteCard(
          title: 'Sales Statistics',
          child: Text('Sales Statistics'),
        )
      ],
    );
  }
}
