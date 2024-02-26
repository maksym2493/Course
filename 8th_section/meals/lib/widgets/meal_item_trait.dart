import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.label,
    required this.iconData,
  });

  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
