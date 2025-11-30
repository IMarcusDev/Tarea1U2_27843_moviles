import 'package:flutter_test/flutter_test.dart';
import 'package:tarea_api_app/src/data/models/zelda_item_model.dart';

void main() {
  group('ZeldaItemModel Tests', () {
    test('fromJson should create ZeldaItemModel correctly', () {
      final json = {
        'id': 'master-sword',
        'name': 'Master Sword',
        'description': 'The legendary sword that seals the darkness',
      };

      final model = ZeldaItemModel.fromJson(json);

      expect(model.id, 'master-sword');
      expect(model.name, 'Master Sword');
      expect(model.description, 'The legendary sword that seals the darkness');
    });

    test('fromJson should handle special characters', () {
      final json = {
        'id': 'test-item',
        'name': 'Ítem Especial™',
        'description': 'Descripción con ñ y acentos',
      };

      final model = ZeldaItemModel.fromJson(json);

      expect(model.name, 'Ítem Especial™');
      expect(model.description, 'Descripción con ñ y acentos');
    });
  });
}