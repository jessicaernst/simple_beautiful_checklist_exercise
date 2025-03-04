import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/config/app_colors.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({super.key, required this.taskCount});

  final int taskCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CircleAvatar ist besser als Container an dieser Stelle, da es die Größe automatisch anpasst
              // dazu ist es weit performanter als Container hier zu verwenden und auch weit weniger Code
              CircleAvatar(
                backgroundColor: AppColors.counterBackground,
                radius: 32, // Bessere Kontrolle als `padding`
                child: Text(
                  "$taskCount",
                  style: TextTheme.of(context).headlineMedium?.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Anzahl der offenen Tasks',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
