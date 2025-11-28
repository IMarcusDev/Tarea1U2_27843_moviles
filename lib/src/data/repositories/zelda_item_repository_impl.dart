import 'package:tarea_api_app/src/data/datasources/zelda_datasource.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class ZeldaItemRepositoryImpl {
  final ZeldaDatasource ds;

  ZeldaItemRepositoryImpl(this.ds);

  Future<List<ZeldaItem>> getZeldaItems({int limit = 20}) async {
    return ds.fetchZeldaItems(limit);
  }
}
