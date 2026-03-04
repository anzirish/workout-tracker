class Workout {
  final int id;
  final String title;
  final String description;
  final int durationMinutes;
  final String difficulty;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.difficulty,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      durationMinutes: json['duration_minutes'],
      difficulty: json['difficulty'],
    );
  }
}
