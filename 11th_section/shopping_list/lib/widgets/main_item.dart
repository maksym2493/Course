import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class MainItem extends StatelessWidget {
  const MainItem({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  final GroceryItem item;
  final void Function(GroceryItem item) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      onDismissed: (direction) => onDismissed(item),
      background: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          color: Colors.red,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    item.category.color,
                    item.category.color.withOpacity(0.5),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 30),
            Text(item.name),
            const Spacer(),
            Text(item.quantity.toString()),
          ],
        ),
      ),
    );
  }
}
