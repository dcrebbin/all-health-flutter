import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Profile {
  int id = 0;
  String name = '';
  String dateOfBirth = '';
  String gender = '';
  int height = 0;
  int weight = 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'height': height,
        'weight': weight,
      };

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    dateOfBirth = json['dateOfBirth'] ?? '';
    gender = json['gender'] ?? '';
    height = json['height'] ?? 0;
    weight = json['weight'] ?? 0;
  }
}

class DailyIntake {
  int id = 0;
  String date = '';
  int water = 0;
  int calories = 0;
  int protein = 0;
  int fat = 0;
  int carbohydrates = 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'water': water,
        'calories': calories,
        'protein': protein,
        'fat': fat,
        'carbohydrates': carbohydrates,
      };

  DailyIntake.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    date = json['date'] ?? '';
    water = json['water'] ?? 0;
    calories = json['calories'] ?? 0;
    protein = json['protein'] ?? 0;
    fat = json['fat'] ?? 0;
    carbohydrates = json['carbohydrates'] ?? 0;
  }
}

class DailyMonitoring {
  int id = 0;
  String date = '';
  int restingHeartRate = 0;
  int sleepScore = 0;
  int bloodOxygen = 0;
  int bloodSugar = 0;

  Map<String, dynamic> bloodPressure = {};

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'restingHeartRate': restingHeartRate,
        'sleepScore': sleepScore,
        'bloodOxygen': bloodOxygen,
        'bloodSugar': bloodSugar,
        'bloodPressure': bloodPressure,
      };

  DailyMonitoring.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    date = json['date'] ?? '';
    restingHeartRate = json['restingHeartRate'] ?? 0;
    sleepScore = json['sleepScore'] ?? 0;
    bloodOxygen = json['bloodOxygen'] ?? 0;
    bloodSugar = json['bloodSugar'] ?? 0;
    bloodPressure = json['bloodPressure'] ?? {};
  }
}

@lazySingleton
class DatabaseService {
  late final Future<Database> database;
  late SharedPreferences prefs;
  initPrefs() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    prefs = sharedPreferences;
  }

  late DailyIntake dailyIntake;
  late DailyMonitoring dailyMonitoring;

  initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'all_health.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE profile(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, date_of_birth TEXT, gender TEXT, height INTEGER, weight INTEGER)');
        await db.execute(
            'CREATE TABLE daily_intake(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,date TEXT, water INTEGER, calories INTEGER, protein INTEGER, fat INTEGER, carbohydrates INTEGER)');
        await db.execute(
            'CREATE TABLE daily_monitoring(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,date TEXT, resting_heart_rate INTEGER, sleep_score INTEGER, blood_oxygen INTEGER, blood_sugar INTEGER, blood_pressure TEXT)');
        return;
      },
      version: 1,
    );
  }

  Future<void> updateMetric(String metric, String value) async {
    final db = await database;
    await db.update('daily_intake', {'${metric}': value});
  }

  Future<void> insertDailyIntake(DailyIntake dailyIntake) async {
    final db = await database;
    await db.insert(
      'daily_intake',
      dailyIntake.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDailyMonitoring(DailyMonitoring dailyMonitoring) async {
    final db = await database;
    await db.insert(
      'daily_monitoring',
      dailyMonitoring.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DailyMonitoring> getDailyMonitoring() async {
    final date = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Get only the date part
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('daily_monitoring', where: 'date = ?', whereArgs: [date]);
    if (maps.isEmpty) {
      dailyMonitoring = DailyMonitoring.fromJson({});
      return dailyMonitoring;
    }
    dailyMonitoring = DailyMonitoring.fromJson(maps[0]);
    return dailyMonitoring;
  }

  Future<DailyIntake> getDailyIntake() async {
    final date = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Get only the date part
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('daily_intake', where: 'date = ?', whereArgs: [date]);

    if (maps.isEmpty) {
      // If no entry exists for today, create a new one
      final newDailyIntake = DailyIntake.fromJson({
        'date': date,
        'water': 0,
        'calories': 0,
        'protein': 0,
        'fat': 0,
        'carbohydrates': 0,
      });
      await insertDailyIntake(newDailyIntake);
      dailyIntake = newDailyIntake;
      return dailyIntake;
    }

    dailyIntake = DailyIntake.fromJson(maps[0]);
    return dailyIntake;
  }

  Future<Profile> getProfile() async {
    final profileJson = prefs.getString('profile');
    if (profileJson == null) {
      return Profile.fromJson({});
    }
    return Profile.fromJson(jsonDecode(profileJson));
  }

  Future<void> updateProfile(Profile profile) async {
    prefs.setString('profile', jsonEncode(profile.toJson()));
  }
}
