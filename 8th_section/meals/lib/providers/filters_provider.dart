import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegeterian: false,
          Filter.vegan: false,
        });

  bool getFilter(Filter filter) => state[filter]!;

  void setFilter(Filter filter, bool isActive) => state = {
        ...state,
        filter: isActive,
      };
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final filters = ref.watch(filtersProvider);

    return meals.where(
      (meal) {
        if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (filters[Filter.vegeterian]! && !meal.isVegetarian) {
          return false;
        }
        if (filters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();
  },
);
