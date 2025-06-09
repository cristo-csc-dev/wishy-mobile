class Wish {
  late int? id;
  late String? docId;
  final String title;
  final String url;
  final String description;
  final DateTime date;

  Wish({
    this.id,
    this.docId,
    required this.title,
    required this.url,
    required this.description,
    required this.date
  });

  factory Wish.fromJson(Map<String, dynamic> json) => Wish(
    id: json['id'] as int?,
    docId: json['docId'] as String?,
    title: json['title'],
    description: json['description'],
    url: json['url'],
    date: DateTime.parse(json['date']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'docId': docId,
    'title': title,
    'description': description,
    'url': url,
    'date': date.toIso8601String(),
  };
}