class StreakData {
  final int streak;
  final String? lastWorkoutDate;

  StreakData({
    required this.streak,
    this.lastWorkoutDate,
  });

  factory StreakData.fromJson(Map<String, dynamic> json) {
    return StreakData(
      streak: json['streak'],
      lastWorkoutDate: json['lastWorkoutDate'],
    );
  }
}