class UserMaterial {
  const UserMaterial({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tests,
  });

  final int id;
  final String title;
  final String description;
  final String imagePath;
  final List<List<String>> tests;
}
