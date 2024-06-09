import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cart.db');
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

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cart (
      id INTEGER PRIMARY KEY,
      name TEXT,
      price REAL,
      discount REAL,
      store TEXT,
      image TEXT,
      type TEXT,
      sizes TEXT,
      targetGroup TEXT,
      colors TEXT,
      material TEXT
    )
    ''');
  }

  Future<void> insertCartItem(ClothingItemModel item) async {
    final db = await instance.database;
    await db.insert('cart', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ClothingItemModel>> fetchCartItems() async {
    final db = await instance.database;
    final result = await db.query('cart');

    return result.map((json) => ClothingItemModel.fromMap(json)).toList();
  }

  Future<void> deleteCartItem(int id) async {
    final db = await instance.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }
}
