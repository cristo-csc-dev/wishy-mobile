import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wishy/wish.dart';

Future<Database> initializeWishDb() async {

  WidgetsFlutterBinding.ensureInitialized();

  return await openDatabase(
    join(await getDatabasesPath(), 'wish_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE wishes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT, url TEXT, date TEXT)',
      );
    },
    version: 1,
  );
}

class WishDao {
  static final WishDao _instance = WishDao._internal();
  WishDao._internal();

  factory WishDao() {
    return _instance;
  }

  Future<Database> get _database async {
    return initializeWishDb();
  }

  Map<String, Object?> toMap(Wish wish) {
    return {
      'id': wish.id,
      'title': wish.title,
      'description': wish.description,
      'url': wish.url,
      'date': wish.date.toIso8601String()
    };
  }

  Future<void> insertWish(Wish wish) async {
    final db = await _database;
    await db.insert(
      'wishes',
      toMap(wish),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Wish>> getWishes() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('wishes');

    return List.generate(maps.length, (i) {
      return Wish(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        url: maps[i]['url'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }
}