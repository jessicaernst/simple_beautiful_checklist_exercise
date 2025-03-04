import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.repository,
    required this.items,
    required this.updateOnChange,
  });

  final DatabaseRepository repository;
  final List<String> items;
  final VoidCallback updateOnChange;

  /// Öffnet einen Dialog zum Bearbeiten eines Tasks und speichert die Änderung
  /// `Future<void>` ist hier nötig, weil `showDialog` und `repository.editItem` asynchron sind.
  /// Wir müssen warten, bis der Dialog geschlossen wurde und die Daten gespeichert wurden,
  /// bevor wir die UI updaten. Ohne `Future<void>` würde `updateOnChange()` eventuell
  /// vor der Speicherung ausgeführt werden.
  Future<void> _editTask(BuildContext context, int index) async {
    TextEditingController editController =
        TextEditingController(text: items[index]);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Task bearbeiten'),
          content: TextField(
            autofocus: true,
            controller: editController,
            decoration: const InputDecoration(hintText: "Task bearbeiten"),
          ),
          actions: [
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Speichern'),
              onPressed: () async {
                if (editController.text.isNotEmpty) {
                  await repository.editItem(index, editController.text);
                  updateOnChange(); // UI-Update nach erfolgreicher Speicherung
                }
                // prüft, ob die UI noch existiert, bevor sie geschlossen wird
                if (!context.mounted) {
                  return; // Verhindert Fehler, falls das UI währenddessen zerstört wurde
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Löscht einen Task aus dem Repository und aktualisiert danach die UI
  ///
  /// `Future<void>` ist hier nötig, weil `deleteItem` asynchron ist. Die UI wird erst
  /// aktualisiert, wenn die Löschung tatsächlich abgeschlossen ist.
  Future<void> _deleteTask(int index) async {
    await repository.deleteItem(index);
    updateOnChange(); // UI-Update erst nach erfolgreicher Löschung
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editTask(context, index),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteTask(index),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        color: Colors.white10,
      ),
    );
  }
}
