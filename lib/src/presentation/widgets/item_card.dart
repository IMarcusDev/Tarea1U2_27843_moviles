import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class ItemCard extends StatelessWidget {
  final ZeldaItem item;
  final VoidCallback? onTap;
  // cache the asset manifest keys to avoid repeated loads
  static Future<Set<String>>? _assetKeysFuture;

  const ItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap:
          onTap ??
          () => Navigator.pushNamed(context, '/detalle', arguments: item),
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
              // Background image (from assets) only if present in AssetManifest,
              // this prevents 404 errors on web when the file is missing.
              FutureBuilder<Set<String>>(
                future: _assetKeysFuture ??= rootBundle
                    .loadString('AssetManifest.json')
                    .then(
                      (s) => (jsonDecode(s) as Map).keys
                          .map((k) => k.toString())
                          .toSet(),
                    ),
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

                  if (snap.connectionState == ConnectionState.done &&
                      snap.hasData) {
                    final keys = snap.data!;
                    // find first candidate that exists
                    String? found;
                    for (final c in candidates) {
                      if (keys.contains(c)) {
                        found = c;
                        break;
                      }
                    }

                    // if not found, try fallback img1
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
                          imageFilter: ui.ImageFilter.blur(
                            sigmaX: 2,
                            sigmaY: 2,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Color.fromRGBO(0, 0, 0, 0.5),
                                  BlendMode.dstIn,
                                ),
                                child: Image.asset(found, fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }

                  // fallback colored background
                  return Positioned.fill(
                    child: Container(
                      color: theme.colorScheme.primary.withAlpha(18),
                    ),
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
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withAlpha(200),
                          fontSize: 11,
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
