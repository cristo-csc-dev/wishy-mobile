class Wish {
  final int id;
  final String? title;
  final String url;
  final String description;
  final DateTime? date;

  const Wish({
    required this.id,
    this.title="My wish",
    required this.url,
    required this.description,
    this.date
  });
}