import 'package:final_project/data/categories.dart';
import 'package:final_project/main.dart';
import 'package:final_project/models/category.dart';
import 'package:final_project/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }

  void _save() {
    final trimedTitle = _titleController.text.trim();
    final trimedDescription = _descriptionController.text.trim();

    if (trimedTitle.length < 4) {
      return _showMessage(
        'Довжина назви повинна бути рівною або більшою за 4.',
      );
    }

    if (trimedDescription.length < 4) {
      return _showMessage(
        'Довжина опису повинна бути рівною або більшою за 4.',
      );
    }

    Navigator.of(context).pop(
      Category(
        id: kNextId++,
        title: trimedTitle,
        amount: 0,
        expenses: [],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBar(title: 'Створення категорії'),
                const SizedBox(height: 10),
                Text(
                  'Назва:',
                  style: kText2,
                ),
                const SizedBox(height: 10),
                TextField(
                  style: kText,
                  maxLength: 25,
                  controller: _titleController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 3,
                    ),
                    hintText: 'Введіть назву',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Опис:',
                  style: kText2,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: TextField(
                    style: kText,
                    maxLength: 100,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      hintText: 'Введіть опис категорії',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: _save,
                        icon: const Icon(
                          Icons.add,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
