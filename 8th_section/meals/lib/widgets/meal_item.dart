import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String upperFirstCharapter(String string) =>
      string[0].toUpperCase() + string.substring(1);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onSelectMeal(meal),
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 40,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          iconData: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 16),
                        MealItemTrait(
                          iconData: Icons.work,
                          label: upperFirstCharapter(meal.complexity.name),
                        ),
                        const SizedBox(width: 16),
                        MealItemTrait(
                          iconData: Icons.attach_money,
                          label: upperFirstCharapter(meal.affordability.name),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
