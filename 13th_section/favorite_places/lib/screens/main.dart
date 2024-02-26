import 'package:favorite_places/providers/places.dart';
import 'package:favorite_places/screens/add.dart';
import 'package:favorite_places/widgets/main_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  void _openAddScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const AddScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => _openAddScreen(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : places.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nothing here.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (ctx, index) => MainItem(place: places[index]),
                  ),
      ),
    );
  }
}
