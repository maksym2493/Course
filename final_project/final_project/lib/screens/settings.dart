import 'package:final_project/main.dart';
import 'package:final_project/models/category.dart';
import 'package:final_project/screens/add_category.dart';
import 'package:final_project/widgets/settings/settings_viewer.dart';
import 'package:final_project/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _addCategory() async {
    final category = await Navigator.of(context).push<Category>(
      MaterialPageRoute(
        builder: (ctx) => const AddCategoryScreen(),
      ),
    );

    if (category != null) {
      setState(() => widget.categories.insert(0, category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const TopBar(title: 'Картка X'),
              const SizedBox(height: 16),
              Expanded(
                child: SettingsViewer(categories: widget.categories),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: _addCategory,
                  icon: const Icon(
                    Icons.add,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
