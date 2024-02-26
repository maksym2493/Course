import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void showMealDetails(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = meals.isEmpty
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              'Nothing here',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          )
        : ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (Meal meal) => showMealDetails(context, meal),
            ),
          );

    return title == null
        ? content
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content,
          );
  }
}
