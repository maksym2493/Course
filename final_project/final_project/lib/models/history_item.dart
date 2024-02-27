class HistoryItem {
  const HistoryItem({
    required this.date,
    required this.expenses,
  });

  final String date;
  final List<double> expenses;
}
