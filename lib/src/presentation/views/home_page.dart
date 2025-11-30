import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_api_app/src/presentation/viewmodels/zelda_items_view_model.dart';
import 'package:tarea_api_app/src/presentation/widgets/item_card.dart';
import 'package:tarea_api_app/src/presentation/widgets/search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ZeldaItemsViewModel>(context, listen: false).loadZeldaItems();
    });
  }

  Future<void> _refresh() async {
    await Provider.of<ZeldaItemsViewModel>(
      context,
      listen: false,
    ).loadZeldaItems();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ZeldaItemsViewModel>(context);
    final theme = Theme.of(context);

    final items = vm.items;
    final filtered = _query.trim().isEmpty
        ? items
        : items
              .where(
                (p) =>
                    p.name.toLowerCase().contains(_query.trim().toLowerCase()),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/IconoTrifuerza.svg',
              width: 20,
              height: 20,
              color: theme.appBarTheme.iconTheme?.color ?? theme.colorScheme.secondary,
            ),
            const SizedBox(width: 8),
            Text(
              'Zelda',
              style: TextStyle(
                color: theme.appBarTheme.titleTextStyle?.color ?? theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.errorMessage != null
          ? Center(
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                  child: AppSearchBar(
                    controller: _searchController,
                    hint: 'Buscar por nombre...',
                    query: _query,
                    onChanged: (v) => setState(() => _query = v),
                    onClear: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: filtered.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Center(
                                  child: Text(
                                    'No se encontraron items para "$_query"',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.85,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final item = filtered[index];
                              return ItemCard(item: item);
                            },
                          ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchController.clear();
          _refresh();
        },
        tooltip: 'Refrescar',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
