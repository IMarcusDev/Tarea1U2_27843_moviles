import '../../domain/entities/pokemon.dart';
import '../datasources/pokeapi_datasource.dart';

class PokemonRepositoryImpl {
  final PokeApiDataSource datasource;

  PokemonRepositoryImpl(this.datasource);

  Future<List<Pokemon>> getPokemons({int limit = 30, int offset = 0}) async {
    return datasource.fetchPokemons(limit, offset);
  }
}
