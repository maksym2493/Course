import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/widgets/filter_switcher.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: const Column(
        children: [
          FilterSwitcher(
            title: 'Gluten-Free',
            subTitle: 'Only include gluten-free meals.',
            filter: Filter.glutenFree,
          ),
          FilterSwitcher(
            title: 'Lactose-Free',
            subTitle: 'Only include lactose-free meals.',
            filter: Filter.lactoseFree,
          ),
          FilterSwitcher(
            title: 'Vegeterian',
            subTitle: 'Only include vegeterian meals.',
            filter: Filter.vegeterian,
          ),
          FilterSwitcher(
            title: 'Vegan',
            subTitle: 'Only include vegan meals.',
            filter: Filter.vegan,
          ),
        ],
      ),
    );
  }
}
