class Wish {
  late int? id;
  final String title;
  final String url;
  final String description;
  final DateTime date;

  Wish({
    this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.date
  });
}