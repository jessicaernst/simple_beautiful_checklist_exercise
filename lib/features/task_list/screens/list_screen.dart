import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/empty_content.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/item_list.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> _items = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// lädt die Daten beim Start der App
  Future<void> _loadInitialData() async {
    setState(() {
      isLoading = true;
    });
    await _updateList();
  }

  /// updated die Liste und akzualisiert das UI auch direkt
  /// da das Abrufen der Daten Zeit benötigt, wird ein LadeIndikator angezeigt und es muss deshalb auch ein Future<void>
  ///statt nur eines voids zurückgegeben werden
  Future<void> _updateList() async {
    final newItems = await widget.repository.getItems();
    setState(() {
      _items.clear();
      _items.addAll(newItems);
      isLoading = false;
    });
  }

  /// fügt einen Task hinzu und aktualisiert die Liste
  /// ohne Future<void> würde _updateList() nicht warten, bis die Daten aktualisiert wurden
  /// das führt dann dazu das der neue Task nicht in der Liste angezeigt wird direkt nachdem er hinzugefügt wurde
  Future<void> _addTask(String task) async {
    if (task.isNotEmpty) {
      await widget.repository.addItem(task);
      _controller.clear();
      await _updateList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meine Checkliste')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _items.isEmpty
                      ? const EmptyContent()
                      : ItemList(
                          repository: widget.repository,
                          items: _items,
                          updateOnChange: _updateList,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Task hinzufügen',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _addTask(_controller.text),
                      ),
                    ),
                    onSubmitted: (value) => _addTask(value),
                  ),
                ),
              ],
            ),
    );
  }
}
