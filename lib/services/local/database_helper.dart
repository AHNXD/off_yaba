import 'package:off_yaba/models/store_offer_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "App.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE Cart(id INTEGER PRIMARY KEY, discount INTEGER NOT NULL, image TEXT NOT NULL, title TEXT NOT NULL, body TEXT NOT NULL, itemCount INTEGER DEFAULT 0);",
      ),
      version: _version,
    );
  }

  static Future<int> addCartItem(StoreOfferModel offer) async {
    final db = await _getDB();
    return await db.insert("Cart", offer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateCartItem(StoreOfferModel offer) async {
    final db = await _getDB();

    return await db.update("Cart", offer.toMap(),
        where: 'id = ?',
        whereArgs: [offer.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteCartItem(StoreOfferModel offer) async {
    final db = await _getDB();
    return await db.delete(
      "Cart",
      where: 'id = ?',
      whereArgs: [offer.id],
    );
  }

  static Future<List<StoreOfferModel>?> getCartItems() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> items = await db.query("Cart");
    print("itemmmmsssss $items");
    if (items.isEmpty) {
      return null;
    }
    return List.generate(
      items.length,
      (index) => StoreOfferModel.fromMap(items[index], source: "local"),
    );
  }
}
