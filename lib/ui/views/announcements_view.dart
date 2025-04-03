import 'package:admin_dashboard/models/announcements_model.dart';
import 'package:admin_dashboard/providers/announcements_provider.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/dialog/announcement_dialog.dart';
import 'package:admin_dashboard/ui/tables/announcements_data_table.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:universal_html/html.dart' as html;

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

    print('Announcements ${announcements.announcements[0].title}');

    return Column(
      // physics: BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Announcement View', style: CustomLabels.h1),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const AnnouncementDialog(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Nuevo anuncio'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: WhiteCard(
            child: AnnouncementsDataTable(),
          ),
        )
      ],
    );
  }
}
