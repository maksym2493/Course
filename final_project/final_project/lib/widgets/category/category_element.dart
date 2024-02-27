import 'package:final_project/main.dart';
import 'package:final_project/models/category.dart';
import 'package:flutter/material.dart';

class CategoryElement extends StatefulWidget {
  const CategoryElement({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryElement> createState() => _CategoryElementElementState();
}

class _CategoryElementElementState extends State<CategoryElement> {
  bool _isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
            borderRadius: _isOpened && widget.category.expenses.isNotEmpty
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${widget.category.title} — ${widget.category.amount.toStringAsFixed(2)} грн.',
                      softWrap: true,
                      style: kText,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  iconSize: 34,
                  onPressed: () => setState(() => _isOpened = !_isOpened),
                  icon: Icon(
                    _isOpened ? Icons.arrow_downward : Icons.add,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: _isOpened
              ? Column(
                  children: [
                    for (var i = 0; i < widget.category.expenses.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: const Border(
                                left: BorderSide(
                                  width: 3,
                                  color: Colors.black,
                                ),
                                bottom: BorderSide(
                                  width: 3,
                                  color: Colors.black,
                                ),
                                right: BorderSide(
                                  width: 3,
                                  color: Colors.black,
                                ),
                              ),
                              borderRadius:
                                  i + 1 < widget.category.expenses.length
                                      ? null
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      widget.category.expenses[i]
                                          .toStringAsFixed(2),
                                      style: kText,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
