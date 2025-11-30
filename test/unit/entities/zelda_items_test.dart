import 'package:flutter_test/flutter_test.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

void main() {
  group('ZeldaItem Entity Tests', () {
    test('ZeldaItem should be created with correct properties', () {
      const id = 'master-sword';
      const name = 'Master Sword';
      const description = 'A legendary sword';

      final item = ZeldaItem(
        id: id,
        name: name,
        description: description,
      );

      expect(item.id, id);
      expect(item.name, name);
      expect(item.description, description);
    });

    test('ZeldaItem should handle empty strings', () {
      final item = ZeldaItem(
        id: '',
        name: '',
        description: '',
      );

      expect(item.id, isEmpty);
      expect(item.name, isEmpty);
      expect(item.description, isEmpty);
    });
  });
}