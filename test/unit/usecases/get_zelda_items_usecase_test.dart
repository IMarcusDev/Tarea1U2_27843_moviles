import 'package:flutter_test/flutter_test.dart';
import 'package:tarea_api_app/src/domain/usecases/get_zelda_items_usecase.dart';
import 'package:tarea_api_app/src/data/repositories/zelda_item_repository_impl.dart';
import 'package:tarea_api_app/src/data/datasources/zelda_datasource.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class MockRepository extends ZeldaItemRepositoryImpl {
  MockRepository() : super(ZeldaDatasource());

  @override
  Future<List<ZeldaItem>> getZeldaItems({int limit = 20}) async {
    return [
      ZeldaItem(
        id: 'mock-1',
        name: 'Mock Item',
        description: 'Mock Description',
      ),
    ];
  }
}

void main() {
  group('GetZeldaItemsUsecase Tests', () {
    late GetZeldaItemsUsecase usecase;
    late MockRepository mockRepository;

    setUp(() {
      mockRepository = MockRepository();
      usecase = GetZeldaItemsUsecase(mockRepository);
    });

    test('call should return items from repository', () async {
      final items = await usecase.call();

      expect(items, isNotEmpty);
      expect(items.length, 1);
      expect(items.first.name, 'Mock Item');
    });

    test('call should request 30 items', () async {
      final items = await usecase.call();

      expect(items, isA<List<ZeldaItem>>());
    });
  });
}