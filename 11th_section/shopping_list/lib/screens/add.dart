import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() {
    return _AddScreenState();
  }
}

class _AddScreenState extends State<AddScreen> {
  bool _isSending = false;
  final _formKey = GlobalKey<FormState>();

  String _enteredName = '';
  int _enteredQuantity = 1;
  Categories _enteredCategory = Categories.vegetables;

  void _createItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isSending = true);

      final url = Uri.https(
        'stalwart-fx-414214-default-rtdb.firebaseio.com',
        'shopping-list.json',
      );

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'name': _enteredName,
              'quantity': _enteredQuantity,
              'category': _enteredCategory.name,
            },
          ),
        );

        if (context.mounted) {
          GroceryItem? item;

          if (response.statusCode >= 400) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 3),
                content: Text('Failed to add item to backend.'),
              ),
            );
          } else {
            final Map<String, dynamic> decodedBody = json.decode(response.body);
            item = GroceryItem(
              id: decodedBody['name']!,
              name: _enteredName,
              quantity: _enteredQuantity,
              category: categories[_enteredCategory]!,
            );
          }

          Navigator.of(context).pop(item);
        }
      } catch (error) {
        if (context.mounted) {
          GroceryItem? item;

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              content: Text('Something went wrong.'),
            ),
          );

          Navigator.of(context).pop(item);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length < 2) {
                    return 'Length must be higer than 1.';
                  }
                  return null;
                },
                onSaved: (value) => _enteredName = value!.trim(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _enteredQuantity.toString(),
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be positive number.';
                        }
                        return null;
                      },
                      onSaved: (value) => _enteredQuantity = int.parse(value!),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _enteredCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.key,
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        category.value.color,
                                        category.value.color.withOpacity(0.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12.5),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) => setState(
                        () => _enteredCategory = value!,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () => _formKey.currentState!.reset(),
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _createItem,
                    child: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
