import 'package:admin_dashboard/providers/news_provider.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/dialog/news_dialog.dart';
import 'package:admin_dashboard/ui/shared/widgets/active_button.dart';
import 'package:admin_dashboard/ui/tables/news_data_table.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<NewsProvider>(context, listen: false).fetchNews());
  }

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsProvider>(context);

    if (news.news.isEmpty) {
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
              Text('Noticias', style: CustomLabels.h1),
              ActiveButton(
                title: 'Agregar Noticia',
                icon: Icons.add,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => const NewsDialog(),
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        if (news.news.isNotEmpty)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: WhiteCard(
                width: double.infinity,
                child: NewsDataTable(),
              ),
            ),
          )
        else
          Column(
            children: [
              const SizedBox(height: 180),
              Text(
                'No hay noticias, agregue una o más noticias desde el botón "Agregar Noticia" de arriba.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          )
      ],
    );
  }
}
