import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/gratitude_entry.dart';
import '../constants/app_constants.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.entriesTableName}(
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        tags TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  Future<String> insertEntry(GratitudeEntry entry) async {
    final db = await database;
    await db.insert(
      AppConstants.entriesTableName,
      _entryToMap(entry),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return entry.id;
  }

  Future<List<GratitudeEntry>> getAllEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => _mapToEntry(map)).toList();
  }

  Future<GratitudeEntry?> getEntryById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _mapToEntry(maps.first);
    }
    return null;
  }

  Future<void> updateEntry(GratitudeEntry entry) async {
    final db = await database;
    await db.update(
      AppConstants.entriesTableName,
      _entryToMap(entry),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<void> deleteEntry(String id) async {
    final db = await database;
    await db.delete(
      AppConstants.entriesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllEntries() async {
    final db = await database;
    await db.delete(AppConstants.entriesTableName);
  }

  Future<List<GratitudeEntry>> getEntriesByTag(GratitudeTag tag) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      where: 'tags LIKE ?',
      whereArgs: ['%${tag.name}%'],
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => _mapToEntry(map)).toList();
  }

  Future<List<GratitudeEntry>> getEntriesByDateRange(DateTime start, DateTime end) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      where: 'created_at BETWEEN ? AND ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => _mapToEntry(map)).toList();
  }

  Future<int> getEntriesCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM ${AppConstants.entriesTableName}');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<Map<GratitudeTag, int>> getTagStatistics() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(AppConstants.entriesTableName);
    
    Map<GratitudeTag, int> tagCounts = {};
    for (GratitudeTag tag in GratitudeTag.values) {
      tagCounts[tag] = 0;
    }

    for (var map in maps) {
      final entry = _mapToEntry(map);
      for (GratitudeTag tag in entry.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }

    return tagCounts;
  }

  Future<int> getCurrentStreak() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      orderBy: 'created_at DESC',
    );

    if (maps.isEmpty) return 0;

    int streak = 0;
    DateTime currentDate = DateTime.now();
    
    // Group entries by date
    Map<String, List<GratitudeEntry>> entriesByDate = {};
    for (var map in maps) {
      final entry = _mapToEntry(map);
      final dateKey = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day).toIso8601String().split('T')[0];
      entriesByDate[dateKey] ??= [];
      entriesByDate[dateKey]!.add(entry);
    }

    // Check consecutive days
    while (true) {
      final dateKey = DateTime(currentDate.year, currentDate.month, currentDate.day).toIso8601String().split('T')[0];
      if (entriesByDate.containsKey(dateKey)) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  Future<void> deleteOldDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    await deleteDatabase(path);
  }

  // Convert GratitudeEntry to Map for SQLite
  Map<String, dynamic> _entryToMap(GratitudeEntry entry) {
    return {
      'id': entry.id,
      'text': entry.text,
      'tags': entry.tags.map((tag) => tag.name).join(','),
      'created_at': entry.createdAt.millisecondsSinceEpoch,
      'updated_at': entry.updatedAt.millisecondsSinceEpoch,
    };
  }

  // Convert Map from SQLite to GratitudeEntry
  GratitudeEntry _mapToEntry(Map<String, dynamic> map) {
    return GratitudeEntry(
      id: map['id'],
      text: map['text'],
      tags: (map['tags'] as String).split(',').map((tagName) {
        return GratitudeTag.values.firstWhere(
          (tag) => tag.name == tagName,
          orElse: () => GratitudeTag.other,
        );
      }).toList(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }
}
