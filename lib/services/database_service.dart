import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class DatabaseService {
  late final Future<Database> database;
  late SharedPreferences prefs;
  initPrefs() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    prefs = sharedPreferences;
  }

  initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'all_health.db'),
      onCreate: (db, version) async {
        return;
      },
      version: 1,
    );
  }
}
