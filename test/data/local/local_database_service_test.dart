import 'package:flutter_test/flutter_test.dart';
import 'package:madang_app/data/local/local_database_service.dart';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_database_service_test.mocks.dart';

@GenerateMocks([LocalDatabaseService])
void main() {
  group('Database Test', () {
    late MockLocalDatabaseService dbLocal;


    setUp(() async {
      dbLocal = MockLocalDatabaseService();
      await dbLocal.clearDb();
    });

    test('Insert item into database', () async {
      //arrange
      final List<CustomerReview> reviews = [CustomerReview(name: "Test", review: "Test", date: "Test")];
      final List<Category> categories = [Category.new(name: "Test")];
      final Menus menu = Menus(foods: categories, drinks: categories);
      final Restaurant item = Restaurant(id: "id", name: "Test", description: "Test", city: "Test", address: "Test", pictureId: "Test", categories: categories, menus: menu, rating: 4.0, customerReviews: reviews);
      when(dbLocal.insertItem(item)).thenAnswer((_) async => true);
      //act
      final result = await dbLocal.insertItem(item);

      //assert
      expect(result, true);
      verify(dbLocal.insertItem(item));
    });

    test('Get AllItems database', () async {
      //arrange
      final Restaurants item = Restaurants(id: "id", name: "Test", description: "Test", city: "Test", pictureId: "Test",rating: 4.0);
      when(dbLocal.getAllItems()).thenAnswer((_) async => [item]);
      //act
      final result = await dbLocal.getAllItems();

      //assert
      expect(result, isA<List<Restaurants>>());
      expect(result, [item]);
      verify(dbLocal.getAllItems());
    });

    test('Get Detail database', () async {
      //arrange
      final List<CustomerReview> reviews = [CustomerReview(name: "Test", review: "Test", date: "Test")];
      final List<Category> categories = [Category.new(name: "Test")];
      final Menus menu = Menus(foods: categories, drinks: categories);
      final Restaurant item = Restaurant(id: "id", name: "Test", description: "Test", city: "Test", address: "Test", pictureId: "Test", categories: categories, menus: menu, rating: 4.0, customerReviews: reviews);
      when(dbLocal.getItemById("id")).thenAnswer((_) async => item);
      //act
      final result = await dbLocal.getItemById("id");

      //assert
      expect(result, const TypeMatcher<Restaurant>());
      verify(dbLocal.getItemById("id"));
    });

    test('remove database', () async {
      //arrange
      when(dbLocal.removeItem("id")).thenAnswer((_) async => true);

      //act
      final result = await dbLocal.removeItem("id");

      //assert
      expect(result, true);
      verify(dbLocal.removeItem("id"));
    });
  });

}