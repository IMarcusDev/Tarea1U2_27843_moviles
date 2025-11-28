import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_api_app/src/presentation/viewmodels/zelda_items_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ZeldaItemsViewModel>(context, listen: false).loadZeldaItems()
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ZeldaItemsViewModel>(context);

    if (vm.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("ZeldaItemsAPI - MVVM + Provider")),
      body: ListView.builder(
        itemCount: vm.items.length,
        itemBuilder: (_, index) {
          final p = vm.items[index];

          return ListTile(
            title: Text('${p.id} - ${p.name.toUpperCase()}'),
            subtitle: Text(p.description),
            onTap: () {
              Navigator.pushNamed(context, "/detalle", arguments: p);
            },
          );
        },
      ),
    );
  }
}
