import 'package:admin_dashboard/providers/announcements_provider.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/dialog/announcement_dialog.dart';
import 'package:admin_dashboard/ui/shared/widgets/active_button.dart';
import 'package:admin_dashboard/ui/tables/announcements_data_table.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class AnnouncementsView extends StatefulWidget {
  const AnnouncementsView({super.key});

  @override
  State<AnnouncementsView> createState() => _AnnouncementsViewState();
}

class _AnnouncementsViewState extends State<AnnouncementsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AnnouncementsProvider>(context, listen: false)
            .fetchAnnouncements());
  }

  @override
  Widget build(BuildContext context) {
    final announcements = Provider.of<AnnouncementsProvider>(context);

    if (announcements.announcements.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Anuncios', style: CustomLabels.h1),
              ActiveButton(
                title: 'Agregar Anuncio',
                icon: Icons.add,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AnnouncementDialog(),
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: WhiteCard(
              width: double.infinity,
              child: AnnouncementsDataTable(),
            ),
          ),
        )
      ],
    );
  }
}
