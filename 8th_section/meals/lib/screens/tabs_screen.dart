import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals_screen.dart';

import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _selectPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    setState(() => _selectedIndex = 0);

    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availibleMeals = ref.watch(filteredMealsProvider);

    final Widget body = _selectedIndex == 0
        ? CategoriesScreen(
            availibleMeals: availibleMeals,
          )
        : MealsScreen(
            meals: ref.watch(favoritesProvider),
          );

    final String text = _selectedIndex == 0 ? 'Categories' : 'Favorites';

    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: body,
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
