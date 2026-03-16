import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/coffee_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('coffee_cafe.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // สร้างตารางข้อมูลตามที่โจทย์กำหนด
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE coffee (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        sweetness INTEGER NOT NULL,
        price REAL NOT NULL,
        status TEXT NOT NULL,
        note TEXT
      )
    ''');
  }

  // ฟังก์ชัน เพิ่มข้อมูล
  Future<int> insertCoffee(Coffee coffee) async {
    final db = await instance.database;
    return await db.insert('coffee', coffee.toMap());
  }

  // ฟังก์ชัน ดึงข้อมูลทั้งหมด
  Future<List<Coffee>> getAllCoffee() async {
    final db = await instance.database;
    final result = await db.query('coffee');
    return result.map((json) => Coffee.fromMap(json)).toList();
  }

  // ฟังก์ชัน แก้ไขข้อมูล
  Future<int> updateCoffee(Coffee coffee) async {
    final db = await instance.database;
    return await db.update(
      'coffee',
      coffee.toMap(),
      where: 'id = ?',
      whereArgs: [coffee.id],
    );
  }

  // ฟังก์ชัน ลบข้อมูล
  Future<int> deleteCoffee(int id) async {
    final db = await instance.database;
    return await db.delete(
      'coffee',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}