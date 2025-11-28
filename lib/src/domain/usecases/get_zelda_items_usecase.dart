import 'package:tarea_api_app/src/data/repositories/zelda_item_repository_impl.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class GetZeldaItemsUsecase {
  final ZeldaItemRepositoryImpl repo;

  GetZeldaItemsUsecase(this.repo);

  Future<List<ZeldaItem>> call() {
    return repo.getZeldaItems(limit: 30);
  }
}
