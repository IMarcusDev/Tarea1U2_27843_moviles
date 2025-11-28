import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_api_app/src/data/datasources/zelda_datasource.dart';
import 'package:tarea_api_app/src/data/repositories/zelda_item_repository_impl.dart';
import 'package:tarea_api_app/src/domain/usecases/get_zelda_items_usecase.dart';
import 'package:tarea_api_app/src/presentation/routes/app_routes.dart';
import 'package:tarea_api_app/src/presentation/viewmodels/zelda_items_view_model.dart';
import 'package:tarea_api_app/src/presentation/theme/app_theme.dart';

void main() {
  final datasource = ZeldaDatasource();
  final repository = ZeldaItemRepositoryImpl(datasource);
  final usecase = GetZeldaItemsUsecase(repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final GetZeldaItemsUsecase? usecase;

  const MyApp({super.key, this.usecase});

  @override
  Widget build(BuildContext context) {
    final effectiveUsecase = usecase ?? GetZeldaItemsUsecase(ZeldaItemRepositoryImpl(ZeldaDatasource()));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ZeldaItemsViewModel(effectiveUsecase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: "/",
        theme: AppTheme.themeData,
      ),
    );
  }
}
