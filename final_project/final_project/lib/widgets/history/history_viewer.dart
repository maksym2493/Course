import 'package:final_project/models/history_item.dart';
import 'package:final_project/widgets/history/history_element.dart';
import 'package:flutter/material.dart';

class HistoryViewer extends StatelessWidget {
  const HistoryViewer({
    super.key,
    required this.history,
  });

  final List<HistoryItem> history;

  @override
  Widget build(BuildContext context) => history.isEmpty
      ? const Text('Nothing here')
      : ListView.builder(
          itemCount: history.length,
          itemBuilder: (ctx, index) => HistoryElement(
            key: ValueKey(history[index].date),
            historyItem: history[index],
          ),
        );
}
