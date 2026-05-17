class Phase {
  const Phase({
    required this.id,
    required this.title,
    required this.description,
  });

  final int id;
  final String title;
  final String description;

  factory Phase.fromJson(Map<String, dynamic> json) => Phase(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
      );
}
