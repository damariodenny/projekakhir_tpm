import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  Database? _db;

  Future<void> initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)",
        );
      },
      version: 1,
    );
    notifyListeners();
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<void> register(String username, String password) async {
    final db = _db;
    if (db == null) {
      throw Exception("Database is not initialized");
    }
    await db.insert(
      'users',
      {'username': username, 'password': _hashPassword(password)},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    final db = _db;
    if (db == null) {
      throw Exception("Database is not initialized");
    }
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: "username = ? AND password = ?",
      whereArgs: [username, _hashPassword(password)],
    );
    final isAuthenticated = maps.isNotEmpty;
    notifyListeners();
    return isAuthenticated;
  }
}
