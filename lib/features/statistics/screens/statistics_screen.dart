import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/statistics/widgets/task_counter_card.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTaskCount = 0;

  // in diesem Fall ist es sinnvoll die Anzahl der Tasks beim Start der App zu laden weil die Anzahl der Tasks sich nicht ändert
  // deshalb hier einmalig über initState()
  @override
  void initState() {
    super.initState();
    loadItemCount();
  }

  /// Holt die aktuelle Anzahl der gespeicherten Tasks aus der Datenbank
  /// und aktualisiert das UI, wenn sich die Zahl geändert hat.
  ///
  /// `Future<void>` ist hier sinnvoll, weil wir `await` verwenden, um die Daten abzurufen.
  /// `Future<void>` hat hier aber mehr mit der Lesbarkeit zu tun, da wir so direkt sehen,
  /// dass hier asynchrone Operationen stattfinden.
  Future<void> loadItemCount() async {
    int taskCount =
        await widget.repository.itemCount; // Anzahl der Tasks abrufen

    // Falls sich die Anzahl geändert hat, seit dem letzten Besuch des Screens, wird das UI aktualisiert
    if (mounted && taskCount != currentTaskCount) {
      setState(() {
        currentTaskCount = taskCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(
                taskCount: currentTaskCount), // Zeigt die Anzahl der Tasks an
          ],
        ),
      ),
    );
  }
}
