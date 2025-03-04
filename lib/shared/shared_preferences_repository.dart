import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _itemsKey = 'items';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<int> get itemCount async {
    final items = await getItems();
    return items.length;
  }

  @override
  Future<List<String>> getItems() async {
    final prefs = await _prefs;
    return prefs.getStringList(_itemsKey) ?? [];
  }

  @override
  Future<void> addItem(String item) async {
    final prefs = await _prefs;
    final items = await getItems();
    items.add(item);
    await prefs.setStringList(_itemsKey, items);
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await _prefs;
    final items = await getItems();
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await prefs.setStringList(_itemsKey, items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final prefs = await _prefs;
    final items = await getItems();
    if (index >= 0 && index < items.length) {
      items[index] = newItem;
      await prefs.setStringList(_itemsKey, items);
    }
  }
}
