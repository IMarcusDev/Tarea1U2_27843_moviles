import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';
import 'package:tarea_api_app/src/presentation/widgets/item_hero.dart';
import 'package:tarea_api_app/src/presentation/widgets/detail_info_card.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ZeldaItem item =
        ModalRoute.of(context)!.settings.arguments as ZeldaItem;
    return Scaffold(
      appBar: AppBar(title: Text(item.name.toUpperCase())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ItemHero(item: item, size: 120),
            const SizedBox(height: 30),
            DetailInfoCard(item: item),
          ],
        ),
      ),
    );
  }
}
