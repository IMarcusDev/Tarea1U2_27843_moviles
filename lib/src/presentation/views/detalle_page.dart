import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';


class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ZeldaItem item = ModalRoute.of(context)!.settings.arguments as ZeldaItem;

    return Scaffold(
      appBar: AppBar(title: Text(item.name.toUpperCase())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    child: Text(item.name.isNotEmpty ? item.name[0].toUpperCase() : '?', style: const TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: Text(
                    item.name.toUpperCase(),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                Text('ID: ${item.id}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16)),
                const SizedBox(height: 12),
                Text(item.description, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
