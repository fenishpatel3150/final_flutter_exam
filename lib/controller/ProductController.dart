import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/ProductModel.dart';

class ProductController extends GetxController {
  late Database db;
  var productList = <Product>[].obs;


  Future<void> _initializeDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'products.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE products(id TEXT PRIMARY KEY, name TEXT, price TEXT)',
        );
      },
      version: 1,
    );
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    final List<Map<String, dynamic>> maps = await db.query('products');
    productList.value = List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<void> addProduct(Product product) async {
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchProducts();
  }
}