import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tarea_api_app/src/data/models/zelda_item_model.dart';

class ZeldaDatasource {
  final String baseUrl = "https://zelda.fanapis.com/api/items";
  final http.Client client;

  ZeldaDatasource({http.Client? client}) : client = client ?? http.Client();

  Future<List<ZeldaItemModel>> fetchZeldaItems(int limit) async {
    final url = Uri.parse("$baseUrl?limit=$limit");

    final resp = await client.get(url);

    if (resp.statusCode != 200) {
      throw Exception("Error al obtener los items");
    }

    final List<dynamic> data = jsonDecode(resp.body)['data'];

    return data.map((e) => ZeldaItemModel.fromJson(e)).toList();
  }
}