import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/workout.dart';
import '../models/workout_history.dart';
import '../models/streak_data.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<Workout>> getWorkouts() async {
    final response = await _dio.get('/workouts');
    final List data = response.data['data'];
    return data.map((json) => Workout.fromJson(json)).toList();
  }

  Future<Workout> getWorkoutById(int id) async {
    final response = await _dio.get('/workouts/$id');
    return Workout.fromJson(response.data['data']);
  }

  Future<List<WorkoutHistory>> getWorkoutHistory(int userId) async {
    final response = await _dio.get('/users/$userId/workout-history');
    final List data = response.data['data']['history'];
    return data.map((json) => WorkoutHistory.fromJson(json)).toList();
  }

  Future<int> completeWorkout(int userId, int workoutId) async {
    final response = await _dio.post(
      '/users/$userId/workouts/$workoutId/complete',
      data: {'completedAt': DateTime.now().toIso8601String()},
    );
    return response.data['data']['streak'];
  }

  Future<StreakData> getStreak(int userId) async {
    final response = await _dio.get('/users/$userId/streak');
    return StreakData.fromJson(response.data['data']);
  }
}
