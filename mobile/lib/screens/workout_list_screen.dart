import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/workout_controller.dart';
import '../config/app_config.dart';
import '../widgets/difficulty_badge.dart';
import 'workout_detail_screen.dart';

class WorkoutListScreen extends StatelessWidget {
  WorkoutListScreen({super.key});

  // Put registers the controller so GetX manages its lifecycle
  final WorkoutController controller = Get.put(WorkoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Workouts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        // Show spinner while loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error with retry button
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchWorkouts,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Pull to refresh + scrollable workout list
        return RefreshIndicator(
          onRefresh: controller.fetchWorkouts,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.workouts.length,
            itemBuilder: (context, index) {
              final workout = controller.workouts[index];
              return _WorkoutCard(
                workout: workout,
                controller: controller,
              );
            },
          ),
        );
      }),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final dynamic workout;
  final WorkoutController controller;

  const _WorkoutCard({required this.workout, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => WorkoutDetailScreen(workout: workout)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      workout.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DifficultyBadge(difficulty: workout.difficulty),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${workout.durationMinutes} min',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Mark Complete button — shows spinner while submitting
              Obx(() {
                final isSubmitting =
                    controller.loadingWorkoutIds.contains(workout.id);
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSubmitting
                        ? null
                        : () => controller.completeWorkout(
                              workout.id,
                              AppConfig.userId,
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1DB954),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Mark Complete',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}