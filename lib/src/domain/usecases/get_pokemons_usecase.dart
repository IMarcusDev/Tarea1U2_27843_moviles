import '../entities/pokemon.dart';
import '../../data/repositories/pokemon_repository_impl.dart';

class GetPokemonsUseCase {
  final PokemonRepositoryImpl repository;

  GetPokemonsUseCase(this.repository);

  Future<List<Pokemon>> call() {
    return repository.getPokemons(limit: 30, offset: 0);
  }
}
