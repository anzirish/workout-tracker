class WorkoutHistory {
  final int entryId;
  final String title;
  final String difficulty;
  final int durationMinutes;
  final DateTime completedAt;

  WorkoutHistory({
    required this.entryId,
    required this.title,
    required this.difficulty,
    required this.durationMinutes,
    required this.completedAt,
  });

  factory WorkoutHistory.fromJson(Map<String, dynamic> json) {
    return WorkoutHistory(
      entryId: json['user_workout_id'],
      title: json['title'],
      difficulty: json['difficulty'],
      durationMinutes: json['duration_minutes'],
      completedAt: DateTime.parse(json['completed_at']),
    );
  }
}