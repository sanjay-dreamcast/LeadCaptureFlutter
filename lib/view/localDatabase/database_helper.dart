


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'event_data_Model.dart';

class DatabaseHelper {
  static const String tableEvents = 'events';
  static const String databaseName = 'events.db';

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableEvents (
          id TEXT PRIMARY KEY,
          name TEXT,
          prefix TEXT,
          type TEXT,
          url TEXT,
          start_datetime TEXT,
          end_datetime TEXT,
          location TEXT,
          logo_image TEXT,
          status INTEGER,
          created TEXT,
          modified TEXT,
          is_sync INTEGER
        )
      ''');
      },
    );
  }

  Future<void> insertEvents(List<EventData> events) async {
    final db = await database;
    Batch batch = db.batch();

    for (var event in events) {
      batch.insert(
        tableEvents, // Use the constant here
        event.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace, // Prevent duplicates
      );
    }

    await batch.commit();
  }

  // Get all events from the database
  Future<List<EventData>> getAllEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableEvents); // Use the constant here

    return List.generate(maps.length, (i) {
      return EventData.fromJson(maps[i]);
    });
  }

  // Clear events table
  Future<void> clearEvents() async {
    final db = await database;
    await db.delete(tableEvents); // Use the constant here
  }
}


