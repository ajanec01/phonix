class Phase {
  const Phase({
    required this.id,
    required this.title,
    required this.description,
    required this.about,
    required this.learningGoals,
    required this.tipsForHome,
  });

  final int id;
  final String title;
  final String description;
  final String about;
  final List<String> learningGoals;
  final List<String> tipsForHome;

  factory Phase.fromJson(Map<String, dynamic> json) => Phase(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        about: json['about'] as String,
        learningGoals: (json['learningGoals'] as List<dynamic>).cast<String>(),
        tipsForHome: (json['tipsForHome'] as List<dynamic>).cast<String>(),
      );
}
