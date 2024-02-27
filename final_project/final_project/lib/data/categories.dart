import 'dart:math';

import 'package:final_project/models/category.dart';

int kNextId = 5;
final _random = Random();

List<double> _getExpenses() {
  final count = _random.nextInt(10);

  return [for (var i = 0; i < count; i++) _random.nextDouble() * 300];
}

final List<Category> categories = [
  Category(
    id: 1,
    title: 'Харчування',
    amount: 3000,
    expenses: _getExpenses(),
  ),
  Category(
    id: 2,
    title: 'Комунальні послуги',
    amount: 30,
    expenses: _getExpenses(),
  ),
  Category(
    id: 3,
    title: 'Навчання',
    amount: 200,
    expenses: _getExpenses(),
  ),
  Category(
    id: 4,
    title: 'Спорт',
    amount: 100,
    expenses: _getExpenses(),
  ),
];
