import 'package:all_health_flutter/services/database_service.dart';
import 'package:all_health_flutter/services/test_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'pages/home/home_screen.dart';

final GetIt getIt = GetIt.instance;

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
  ],
);

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  registerServices();
  await loadApplication();
  runApp(const MyApp());
}

loadApplication() async {
  await getIt<DatabaseService>().initPrefs();
  await getIt<DatabaseService>().initDatabase();
}

registerServices() {
  getIt.registerSingleton<TestService>(TestService());
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      color: const Color.fromARGB(0, 255, 255, 255),
      title: 'All Health',
      routerConfig: _router,
    );
  }
}
