import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoritesProvider);
    final notifier = ref.read(favoritesProvider.notifier);
    final isFavorite = notifier.isFavorite(meal);

    return IconButton(
      onPressed: () => notifier.toggleFavorite(meal),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Icon(
          Icons.star,
          key: ValueKey(isFavorite),
          color: isFavorite ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
