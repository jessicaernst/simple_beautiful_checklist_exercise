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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: AppColors.cardBackground,
        // muss man auf setzen weil Card standardmäßig Schatten hat und im only DarkMode sind shadows Design Smells
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.counterBackground,
                radius: 28, // Bessere Kontrolle als `padding`
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
