import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/add.dart';
import 'package:shopping_list/widgets/main_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _error;
  bool _isLoading = true;
  final _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'stalwart-fx-414214-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    try {
      final response = await http.get(url);

      if (response.body == 'null') {
        setState(() => _isLoading = false);
        return;
      }

      if (response.statusCode >= 400) {
        setState(() => _error = 'Failed to load items from backend.');
        return;
      }

      final Map<String, dynamic> decodedBody = json.decode(response.body);

      setState(
        () {
          _isLoading = false;
          _groceryItems.clear();
          for (final item in decodedBody.entries) {
            _groceryItems.add(
              GroceryItem(
                id: item.key,
                name: item.value['name'],
                quantity: item.value['quantity'],
                category: categories[Categories.values.firstWhere(
                  (category) => category.name == item.value['category'],
                )]!,
              ),
            );
          }
        },
      );
    } catch (error) {
      setState(() => _error = 'Something went wrong.');
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const AddScreen(),
      ),
    );

    if (newItem != null) setState(() => _groceryItems.add(newItem));
  }

  void _removeItem(GroceryItem item) async {
    final itemIndex = _groceryItems.indexOf(item);
    setState(() => _groceryItems.removeAt(itemIndex));

    final url = Uri.https(
      'stalwart-fx-414214-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    try {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        setState(() => _groceryItems.insert(itemIndex, item));

        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              content: Text('Failed to delete item from backend.'),
            ),
          );
        }
      }
    } catch (error) {
      setState(() => _groceryItems.insert(itemIndex, item));

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Something went wrong.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _error != null ? null : _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _error != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(_error!),
                ),
              ],
            )
          : _isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : _groceryItems.isEmpty
                  ? const Center(
                      child: Text('Nothing here.'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        itemCount: _groceryItems.length,
                        itemBuilder: (cxt, index) => MainItem(
                          item: _groceryItems[index],
                          onDismissed: _removeItem,
                        ),
                      ),
                    ),
    );
  }
}
