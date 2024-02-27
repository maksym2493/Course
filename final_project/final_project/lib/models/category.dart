class Category {
  Category({
    required this.id,
    required this.title,
    required this.amount,
    required this.expenses,
  });

  final int id;
  String title;
  final double amount;
  final List<double> expenses;
}
