import 'dart:math';

import 'package:final_project/models/history_item.dart';

final _random = Random();

List<HistoryItem> _gen() {
  final List<HistoryItem> histoty = [];
  for (var i = 20; i > 10; i--) {
    final count = _random.nextInt(10);
    histoty.add(
      HistoryItem(
        date: '$i.04.2023',
        expenses: [for (var j = 0; j < count; j++) _random.nextDouble() * 300],
      ),
    );
  }

  return histoty;
}

final List<HistoryItem> history = _gen();
