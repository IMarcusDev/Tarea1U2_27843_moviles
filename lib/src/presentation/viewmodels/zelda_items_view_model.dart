import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/domain/entities/zelda_item.dart';
import 'package:tarea_api_app/src/domain/usecases/get_zelda_items_usecase.dart';

class ZeldaItemsViewModel extends ChangeNotifier {
  final GetZeldaItemsUsecase getZeldaItems;

  ZeldaItemsViewModel(this.getZeldaItems);

  List<ZeldaItem> items = [];
  bool loading = false;
  String? errorMessage;

  Future<void> loadZeldaItems() async {
    loading = true;
    notifyListeners();

    try {
      items = await getZeldaItems();
    } catch (e) {
      errorMessage = "Error al cargar los items";
    }

    loading = false;
    notifyListeners();
  }
}
