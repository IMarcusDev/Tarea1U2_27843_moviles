import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';


class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ZeldaItem item = ModalRoute.of(context)!.settings.arguments as ZeldaItem;

    return Scaffold(
      appBar: AppBar(title: Text(item.name.toUpperCase())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 18,
          children: [
            Text("ID: ${item.id}", style: const TextStyle(fontSize: 22)),
            Text(
              item.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold
              )
            ),
            Text(item.description)
          ],
        ),
      ),
    );
  }
}
