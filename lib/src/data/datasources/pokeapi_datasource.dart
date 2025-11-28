import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

class PokeApiDataSource {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<List<PokemonModel>> fetchPokemons(int limit, int offset) async {
    final url = Uri.parse("$baseUrl?limit=$limit&offset=$offset");

    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception("Error al obtener pokemons");
    }

    final data = jsonDecode(resp.body);
    final List results = data["results"];

    return results.map((e) => PokemonModel.fromJson(e)).toList();
  }
}
