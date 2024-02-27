import 'package:final_project/models/category.dart';
import 'package:final_project/widgets/settings/settings_item.dart';
import 'package:flutter/material.dart';

class SettingsViewer extends StatefulWidget {
  const SettingsViewer({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  State<SettingsViewer> createState() => _SettingsViewerState();
}

class _SettingsViewerState extends State<SettingsViewer> {
  void _saveTitle(Category category, String title) {
    category.title = title;
  }

  void _deleteCategory(Category category) {
    final categoryIndex = widget.categories.indexOf(category);

    setState(() => widget.categories.removeAt(categoryIndex));

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Категорія видалена.'),
        action: SnackBarAction(
          label: 'Скасувати',
          onPressed: () => setState(
            () => widget.categories.insert(categoryIndex, category),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.categories.isEmpty
      ? const Text('Nothing here')
      : ListView.builder(
          itemCount: widget.categories.length,
          itemBuilder: (ctx, index) => SettingsItem(
            key: ValueKey(widget.categories[index].id),
            category: widget.categories[index],
            onDeleted: () => _deleteCategory(
              widget.categories[index],
            ),
            onUpdatedTitle: (title) => _saveTitle(
              widget.categories[index],
              title,
            ),
          ),
        );
}
