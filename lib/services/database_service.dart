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
        await db.execute(
            'CREATE TABLE profile(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, date_of_birth TEXT, gender TEXT, height INTEGER, weight INTEGER)');
        return;
      },
      version: 1,
    );
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
