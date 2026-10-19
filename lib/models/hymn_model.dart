class Hymn {
  final int id;
  final int number;
  final String title;
  final List<String> verses;
  final String? chorus;
  final String category;

  Hymn({
    required this.id,
    required this.number,
    required this.title,
    required this.verses,
    this.chorus,
    required this.category,
  });

  factory Hymn.fromJson(Map<String, dynamic> json) {
    return Hymn(
      id: json['id'],
      number: json['number'],
      title: json['title'],
      verses: List<String>.from(json['verses']),
      chorus: json['chorus'],
      category: json['category'] ?? 'Main',
    );
  }
}