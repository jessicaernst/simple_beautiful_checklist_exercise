import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/config/app_theme.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/shared_preferences_repository.dart';
import 'features/splash/splash_screen.dart';
import 'home_screen.dart';

void main() async {
  // sorgt dafür dass WidgetsBinding initialisiert wird und databaseRepository geladen ist bevor die App startet
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseRepository repository = SharedPreferencesRepository();

  runApp(MainApp(repository: repository));
}

/// Da das UI ausschließlich im DarkMode funktioniert so wie es hier deklariert wurde, verwende ich `ThemeData.dark()`ganz einfach hier
/// und habe alles Überflüssige raus geworfen, das vorher da war.
class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      title: 'Checklisten App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => HomeScreen(repository: repository),
      },
    );
  }
}
