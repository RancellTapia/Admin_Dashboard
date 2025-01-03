import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Text('Icon View', style: CustomLabels.h1),
        SizedBox(height: 10),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
              ),
              WhiteCard(
                title: 'access_alarm_sharp',
                width: 170,
                child: Center(
                  child: Icon(Icons.access_alarm_sharp),
                ),
              ),
              WhiteCard(
                title: 'back_hand_rounded',
                width: 170,
                child: Center(
                  child: Icon(Icons.back_hand_rounded),
                ),
              ),
              WhiteCard(
                title: 'calendar_month_sharp',
                width: 170,
                child: Center(
                  child: Icon(Icons.calendar_month_sharp),
                ),
              ),
              WhiteCard(
                title: 'tiktok_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.tiktok_outlined),
                ),
              ),
              WhiteCard(
                title: 'bar_chart_rounded',
                width: 170,
                child: Center(
                  child: Icon(Icons.bar_chart_rounded),
                ),
              ),
              WhiteCard(
                title: 'do_disturb_alt_sharp',
                width: 170,
                child: Center(
                  child: Icon(Icons.do_disturb_alt_sharp),
                ),
              ),
              WhiteCard(
                title: 'trending_up_rounded',
                width: 170,
                child: Center(
                  child: Icon(Icons.trending_up_rounded),
                ),
              ),
            ])
      ],
    );
  }
}
