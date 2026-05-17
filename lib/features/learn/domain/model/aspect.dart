class Aspect {
  const Aspect({
    required this.number,
    required this.title,
    required this.description,
    required this.activityLabel,
    required this.iconKey,
    required this.parentGuide,
  });

  final int number;
  final String title;
  final String description;
  final String activityLabel;
  final String iconKey;
  final String parentGuide;

  factory Aspect.fromJson(Map<String, dynamic> json) => Aspect(
        number: json['number'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        activityLabel: json['activityLabel'] as String,
        iconKey: json['icon'] as String,
        parentGuide: json['parentGuide'] as String,
      );
}
