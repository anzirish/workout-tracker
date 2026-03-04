import 'package:get/get.dart';
import '../models/workout.dart';
import '../services/api_service.dart';

class WorkoutController extends GetxController {
  final ApiService _api = ApiService();

  // Observables — UI rebuilds automatically when these change
  final workouts = <Workout>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // Track which workout IDs are currently being submitted
  final loadingWorkoutIds = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      workouts.value = await _api.getWorkouts();
    } catch (e) {
      errorMessage.value = 'Failed to load workouts. Check your connection.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeWorkout(int workoutId, int userId) async {
    loadingWorkoutIds.add(workoutId);
    try {
      final newStreak = await _api.completeWorkout(userId, workoutId);
      Get.snackbar(
        'Workout Complete!',
        'Current streak: $newStreak day${newStreak == 1 ? '' : 's'}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not mark workout as complete. Try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loadingWorkoutIds.remove(workoutId);
    }
  }
}