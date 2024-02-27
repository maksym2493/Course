import 'package:final_project/main.dart';
import 'package:final_project/models/category.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    super.key,
    required this.category,
    required this.onDeleted,
    required this.onUpdatedTitle,
  });

  final Category category;
  final void Function() onDeleted;
  final void Function(String title) onUpdatedTitle;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool _isDeleted = false;
  late TextEditingController _titleController;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }

  void _update() {
    final trimedTitle = _titleController.text.trim();

    if (trimedTitle.length < 4) {
      return _showMessage(
        'Довжина назви повинна бути рівною або більшою за 4.',
      );
    }

    widget.onUpdatedTitle(trimedTitle);
    _titleController.text = trimedTitle;
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.category.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: _isDeleted
          ? null
          : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                          child: TextField(
                            maxLength: 25,
                            controller: _titleController,
                            style: kText,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: Colors.black,
                            ),
                            right: BorderSide(
                              width: 3,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 20,
                          ),
                          child: TextButton(
                            onPressed: _update,
                            child: const Text(
                              '🖍',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            setState(() => _isDeleted = true);
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                            );
                            widget.onDeleted();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
    );
  }
}
