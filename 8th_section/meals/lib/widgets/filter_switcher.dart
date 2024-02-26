import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FilterSwitcher extends ConsumerWidget {
  const FilterSwitcher({
    super.key,
    required this.title,
    required this.subTitle,
    required this.filter,
  });

  final String title;
  final Filter filter;
  final String subTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(filtersProvider);
    final notifier = ref.watch(filtersProvider.notifier);

    return SwitchListTile(
      value: notifier.getFilter(filter),
      onChanged: (isChecked) => notifier.setFilter(filter, isChecked),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
