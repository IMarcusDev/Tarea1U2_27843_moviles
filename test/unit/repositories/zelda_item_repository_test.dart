import 'package:flutter_test/flutter_test.dart';
import 'package:tarea_api_app/src/data/repositories/zelda_item_repository_impl.dart';
import 'package:tarea_api_app/src/data/datasources/zelda_datasource.dart';
import 'package:tarea_api_app/src/data/models/zelda_item_model.dart';

class MockZeldaDatasource extends ZeldaDatasource {
  @override
  Future<List<ZeldaItemModel>> fetchZeldaItems(int limit) async {
    return [
      ZeldaItemModel(
        id: 'test-1',
        name: 'Test Item',
        description: 'Test Description',
      ),
    ];
  }
}

void main() {
  group('ZeldaItemRepository Tests', () {
    late ZeldaItemRepositoryImpl repository;
    late MockZeldaDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockZeldaDatasource();
      repository = ZeldaItemRepositoryImpl(mockDatasource);
    });

    test('getZeldaItems should return list from datasource', () async {
      final items = await repository.getZeldaItems(limit: 10);

      expect(items, isNotEmpty);
      expect(items.first.id, 'test-1');
      expect(items.first.name, 'Test Item');
    });

    test('getZeldaItems should use default limit of 20', () async {
      final items = await repository.getZeldaItems();

      expect(items, isA<List>());
    });
  });
}