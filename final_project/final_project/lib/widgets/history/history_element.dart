import 'package:final_project/main.dart';
import 'package:final_project/models/history_item.dart';
import 'package:final_project/screens/advice.dart';
import 'package:flutter/material.dart';

class HistoryElement extends StatefulWidget {
  const HistoryElement({
    super.key,
    required this.historyItem,
  });

  final HistoryItem historyItem;

  @override
  State<HistoryElement> createState() => _HistoryElementState();
}

class _HistoryElementState extends State<HistoryElement> {
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
            borderRadius: _isOpened && widget.historyItem.expenses.isNotEmpty
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.historyItem.date,
                  style: kText,
                ),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: IconButton(
                    iconSize: 34,
                    onPressed: () => setState(() => _isOpened = !_isOpened),
                    icon: Icon(
                      _isOpened ? Icons.arrow_downward : Icons.add,
                    ),
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
                    for (var i = 0; i < widget.historyItem.expenses.length; i++)
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
                                  i + 1 < widget.historyItem.expenses.length
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
                                SizedBox(
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      widget.historyItem.expenses[i]
                                          .toStringAsFixed(2),
                                      style: kText,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              const AdviceScreen(),
                                        ),
                                      ),
                                      child: Image.asset(
                                        'assets/images/advice_ico.png',
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
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
