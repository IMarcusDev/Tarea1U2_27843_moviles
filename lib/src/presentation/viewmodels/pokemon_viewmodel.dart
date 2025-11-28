import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemons_usecase.dart';

class PokemonViewModel extends ChangeNotifier {
  final GetPokemonsUseCase getPokemons;

  PokemonViewModel(this.getPokemons);

  List<Pokemon> pokemons = [];
  bool loading = false;
  String? errorMessage;

  Future<void> loadPokemons() async {
    loading = true;
    notifyListeners();

    try {
      pokemons = await getPokemons();
    } catch (e) {
      errorMessage = "Error al cargar los Pokémon";
    }

    loading = false;
    notifyListeners();
  }
}
