import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class ItemCard extends StatelessWidget {
  final ZeldaItem item;
  final VoidCallback? onTap;

  const ItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap ?? () => Navigator.pushNamed(context, '/detalle', arguments: item),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background area: try to load an asset image for this item id,
              // otherwise show a subtle colored background.
              FutureBuilder<String?>(
                future: () async {
                  const String pfx = 'assets/images/';
                  final path = '$pfx${item.id}.png';
                  try {
                    await rootBundle.load(path);
                    return path;
                  } catch (_) {
                    return null;
                  }
                }(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done && snap.hasData && snap.data != null) {
                    return Image.asset(
                      snap.data!,
                      fit: BoxFit.cover,
                    );
                  }

                  return Container(
                    color: theme.colorScheme.primary.withAlpha(18),
                  );
                },
              ),

              // Center avatar / icon
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: item.id,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: theme.colorScheme.primary.withAlpha(51),
                    child: Text(
                      item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: 24,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom gradient and texts
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        theme.colorScheme.surface.withAlpha(200),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(200), fontSize: 11),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
