import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';

class ZeldaItemModel extends ZeldaItem {
  ZeldaItemModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory ZeldaItemModel.fromJson(Map<String, dynamic> json) {
    return ZeldaItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
