import 'package:final_project/models/category.dart';
import 'package:final_project/widgets/category/category_element.dart';
import 'package:flutter/material.dart';

class CategoryViewer extends StatelessWidget {
  const CategoryViewer({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) => categories.isEmpty
      ? const Text('Nothing here')
      : ListView.builder(
          itemCount: categories.length,
          itemBuilder: (ctx, index) => CategoryElement(
            category: categories[index],
          ),
        );
}
