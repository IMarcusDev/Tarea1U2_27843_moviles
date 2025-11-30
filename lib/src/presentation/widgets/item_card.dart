import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class ItemCard extends StatelessWidget {
  final ZeldaItem item;
  final VoidCallback? onTap;
  static Future<Set<String>>? _assetKeysFuture;

  const ItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap ?? () => Navigator.pushNamed(context, '/detalle', arguments: item),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FutureBuilder<Set<String>>(
                future: _assetKeysFuture ??= rootBundle
                    .loadString('AssetManifest.json')
                    .then((s) => (jsonDecode(s) as Map).keys.map((k) => k.toString()).toSet()),
                builder: (context, snap) {
                  final candidates = <String>[
                    'assets/images/${item.id}.png',
                    'assets/images/${item.id}.jpg',
                    'assets/images/${item.id}.jpeg',
                    'assets/images/${item.id}.webp',
                  ];

                  final fallbackCandidates = <String>[
                    'assets/images/img1.png',
                    'assets/images/img1.jpg',
                    'assets/images/img1.jpeg',
                    'assets/images/img1.webp',
                  ];

                  if (snap.connectionState == ConnectionState.done && snap.hasData) {
                    final keys = snap.data!;
                    String? found;
                    
                    for (final c in candidates) {
                      if (keys.contains(c)) {
                        found = c;
                        break;
                      }
                    }

                    if (found == null) {
                      for (final f in fallbackCandidates) {
                        if (keys.contains(f)) {
                          found = f;
                          break;
                        }
                      }
                    }

                    if (found != null) {
                      return Positioned.fill(
                        child: ImageFiltered(
                          imageFilter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Color.fromRGBO(0, 0, 0, 0.5),
                              BlendMode.dstIn,
                            ),
                            child: Image.asset(found, fit: BoxFit.cover),
                          ),
                        ),
                      );
                    }
                  }

                  return Positioned.fill(
                    child: Container(
                      color: theme.colorScheme.primary.withOpacity(0.08),
                    ),
                  );
                },
              ),

              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: item.id,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Center(
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
              ),
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
                        Colors.black.withOpacity(0.85),
                      ],
                      stops: const [0.0, 1.0],
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
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                          height: 1.3,
                        ),
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