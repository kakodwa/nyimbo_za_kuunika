class Chorus {
  final int id;
  final int number;
  final String title;
  final String category; // 'Olemekeza' or 'Opembedza'

  Chorus({
    required this.id,
    required this.number,
    required this.title,
    required this.category,
  });

  factory Chorus.fromJson(Map<String, dynamic> json) {
    return Chorus(
      id: json['id'],
      number: json['number'],
      title: json['title'],
      category: json['category'],
    );
  }
}