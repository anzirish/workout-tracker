import 'package:get/get.dart';
import '../models/workout_history.dart';
import '../models/streak_data.dart';
import '../services/api_service.dart';

class HistoryController extends GetxController {
  final ApiService _api = ApiService();

  final history = <WorkoutHistory>[].obs;
  final streak = Rxn<StreakData>(); // Rxn = nullable observable
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll(1); // user ID 1
  }

  Future<void> fetchAll(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Fetch both streak and history in parallel
      final results = await Future.wait([
        _api.getStreak(userId),
        _api.getWorkoutHistory(userId),
      ]);
      streak.value = results[0] as StreakData;
      history.value = results[1] as List<WorkoutHistory>;
    } catch (e) {
      errorMessage.value = 'Failed to load history. Check your connection.';
    } finally {
      isLoading.value = false;
    }
  }
}