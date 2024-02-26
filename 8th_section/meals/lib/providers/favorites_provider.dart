import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Meal meal) {
    isFavorite(meal)
        ? state = state.where((m) => m.id != meal.id).toList()
        : state = [meal, ...state];
  }

  bool isFavorite(Meal meal) => state.contains(meal);
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Meal>>(
  (ref) => FavoritesNotifier(),
);
