import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = "restaurant-app.db";
  static const String _tableRestaurant = 'restaurant';
  static const String _tableCategory = 'category';
  static const String _tableMenus = 'menu';
  static const String _tableReviews = 'reviews';
  static const int _version = 1;
  

  Future<void> createTables(Database db) async {
    await db.execute("""
    create table $_tableRestaurant(
    id TEXT PRIMARY KEY,
    name TEXT,
    description TEXT,
    city TEXT,
    address TEXT,
    pictureId TEXT,
    rating REAL)
    """);

    await db.execute("""
    create table $_tableCategory(
    id Text,
    name TEXT)
    """);

    await db.execute("""
    create table $_tableMenus(
    id Text,
    name TEXT,
    type TEXT)
    """);

    await db.execute("""
    create table $_tableReviews(
    id TEXT,
    name TEXT,
    review TEXT,
    date TEXT)
    """);
  }

  Future<Database> _initializeDb() async {
    return openDatabase(_databaseName, version: _version,
        onCreate: (db, version) async {
      await createTables(db);
    });
  }

  Future<bool> insertItem(Restaurant item) async {
    final db = await _initializeDb();
    final stateRestaurant = await db.rawInsert(
        'Insert into $_tableRestaurant(id, name, description, city, address, pictureId, rating) VALUES ("${item.id}","${item.name}","${item.description}","${item.city}","${item.address}","${item.pictureId}",${item.rating})');

    int stateCategory = 0;
    int stateMenus = 0;
    int stateReviews = 0;
    if (item.categories.isNotEmpty) {
      String values = item.categories.map((data) {
        return '("${item.id}","${data.name}")';
      }).join(',');
      stateCategory = await db
          .rawInsert('Insert into $_tableCategory(id, name) VALUES $values');
    }

    if (item.customerReviews.isNotEmpty) {
      String values = item.customerReviews.map((data) {
        return '("${item.id}","${data.name}","${data.review}","${data.date}")';
      }).join(',');

      stateReviews = await db.rawInsert(
          'Insert into $_tableReviews(id, name, review, date) VALUES $values');
    }
    if (item.menus.foods.isNotEmpty || item.menus.drinks.isNotEmpty) {
      String foods = item.menus.foods.map((data) {
        return '("${item.id}","${data.name}","food")';
      }).join(',');
      String drinks = item.menus.drinks.map((data) {
        return '("${item.id}","${data.name}","drink")';
      }).join(',');
      stateMenus = await db.rawInsert(
          'Insert into $_tableMenus(id, name, type) VALUES $foods,$drinks');
    }

    return stateRestaurant == 1 &&
        (stateCategory == 1 || stateReviews == 1 || stateMenus == 1);
  }

  Future<List<Restaurants>> getAllItems() async {
    final db = await _initializeDb();
    final result = await db.query(_tableRestaurant);

    return result.map((result) => Restaurants.fromJson(result)).toList();
  }

  Future<Restaurant?> getItemById(String id) async {
    final db = await _initializeDb();
    final restaurant = await db.query(_tableRestaurant,
        where: "id = ?", whereArgs: [id], limit: 1);
    final category = await db
        .rawQuery("Select name from $_tableCategory where id = ?", [id]);
    final foods = await db.rawQuery(
        "Select name from $_tableMenus where id = ? AND type = 'food'", [id]);
    final drinks = await db.rawQuery(
        "Select name from $_tableMenus where id = ? AND type = 'drink'", [id]);
    final reviews = await db.rawQuery(
        "Select name, review, date from $_tableReviews where id = ?", [id]);
    return restaurant
        .map((result) => Restaurant(
            id: result["id"].toString(),
            name: result["name"].toString(),
            description: result["description"].toString(),
            city: result["city"].toString(),
            address: result["address"].toString(),
            pictureId: result["pictureId"].toString(),
            categories:
                List<Category>.from(category.map((e) => Category.fromJson(e))),
            menus: Menus(
                foods: List<Category>.from(
                    foods.map((menu) => Category.fromJson(menu))),
                drinks: List<Category>.from(
                    drinks.map((menu) => Category.fromJson(menu)))),
            rating: result["rating"] as double,
            customerReviews: List<CustomerReview>.from(
                reviews.map((x) => CustomerReview.fromJson(x)))))
        .first;
  }

  Future<bool> removeItem(String id) async {
    final db = await _initializeDb();
    final restaurant =
        await db.delete(_tableRestaurant, where: 'id = ?', whereArgs: [id]);
    final categories =
        await db.delete(_tableCategory, where: 'id = ?', whereArgs: [id]);
    final menus =
        await db.delete(_tableMenus, where: 'id = ?', whereArgs: [id]);
    final reviews =
        await db.delete(_tableReviews, where: 'id = ?', whereArgs: [id]);

    return restaurant == 1 && categories == 1 && menus == 1 && reviews == 1;
  }
}
