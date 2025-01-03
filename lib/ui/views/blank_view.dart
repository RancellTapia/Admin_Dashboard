import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Text('Blank View', style: CustomLabels.h1),
        SizedBox(height: 10),
        WhiteCard(
          title: 'Blank View',
          child: Text('Blank View'),
        )
      ],
    );
  }
}
