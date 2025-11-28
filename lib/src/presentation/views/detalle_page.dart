import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon =
    ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name.toUpperCase())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, width: 150),
            const SizedBox(height: 20),
            Text("ID: ${pokemon.id}", style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Text(pokemon.name.toUpperCase(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
