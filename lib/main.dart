import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/data/datasources/pokeapi_datasource.dart';
import 'src/data/repositories/pokemon_repository_impl.dart';
import 'src/domain/usecases/get_pokemons_usecase.dart';
import 'src/presentation/viewmodels/pokemon_viewmodel.dart';
import 'src/presentation/routes/app_routes.dart';

void main() {
  final datasource = PokeApiDataSource();
  final repository = PokemonRepositoryImpl(datasource);
  final usecase = GetPokemonsUseCase(repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final GetPokemonsUseCase usecase;

  const MyApp({super.key, required this.usecase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonViewModel(usecase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: "/",
        theme: ThemeData(
          colorSchemeSeed: Colors.red,
          useMaterial3: true,
        ),
      ),
    );
  }
}
