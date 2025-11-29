import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class ItemHero extends StatelessWidget {
  final ZeldaItem item;
  final double size;

  const ItemHero({super.key, required this.item, this.size = 120});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.secondary,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.secondary.withAlpha(102),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Hero(
            tag: item.id,
            child: Text(
              item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: (size * 0.4).clamp(24, 64),
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
