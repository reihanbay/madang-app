import 'package:flutter_test/flutter_test.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/data/model/restaurant_reviews_response.dart';
import 'package:madang_app/data/model/restaurant_search_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_services_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
  });

  group('FetchRestaurant', () {
    final response = RestaurantsResponse.fromJson({
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
      ]
    });

    test('fetchData restaurant return data successfully', () async {
      //Arrange atur response mock
      when(mockApiServices.getRestaurants())
          .thenAnswer((_) async => Future.value(response));

      //act
      final result = await mockApiServices.getRestaurants();

      //expect
      expect(result, const TypeMatcher<RestaurantsResponse>());
    });
    test('fetchData restaurant return data fail', () async {
      //Arrange atur response mock
      when(mockApiServices.getRestaurants()).thenAnswer(
          (_) async => throw Exception("Failed to load restaurants"));
      //act
      final result = mockApiServices.getRestaurants();
      //expect
      expect(result, throwsException);
    });
  });

  group('Fetch DetailRestaurant', () {
    final response = DetailRestaurantResponse.fromJson({
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    });

    test('fetchData detailRestaurant return data successfully', () async {
      //Arrange atur response mock
      when(mockApiServices.getDetailRestaurant("rqdv5juczeskfw1e867"))
          .thenAnswer((_) async => Future.value(response));

      //act
      final result =
          await mockApiServices.getDetailRestaurant("rqdv5juczeskfw1e867");

      //expect
      expect(result, isA<DetailRestaurantResponse>());
    });

    test("fetch data detail restaurant throw exception", () async {
      //Arrange atur response mock
      when(mockApiServices.getDetailRestaurant("rqdv5juczeskfw1e867s"))
          .thenAnswer((_) async => throw Exception("Failed to load detail"));

      //act
      final result = mockApiServices.getDetailRestaurant("rqdv5juczeskfw1e867s");

      //expect
      expect(result, throwsException);
    });
  });

  group('Search Restaurant', () {
    final response = SearchRestaurantsResponse.fromJson({
      "error": false,
      "founded": 1,
      "restaurants": [
        {
          "id": "fnfn8mytkpmkfw1e867",
          "name": "Makan mudah",
          "description":
              "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
          "pictureId": "22",
          "city": "Medan",
          "rating": 3.7
        }
      ]
    });
    test('fetchData SearchRestaurant data successfully', () async {
      //Arrange atur response mock
      when(mockApiServices.searchRestaurants("Mel"))
          .thenAnswer((_) async => Future.value(response));

      //act
      final result = await mockApiServices.searchRestaurants("Mel");

      //expect
      expect(result, const TypeMatcher<SearchRestaurantsResponse>());
    });

    test('throw SearchRestaurant when data not found', () async {
      //Arrange atur response mock
      when(mockApiServices.searchRestaurants("Mel")).thenAnswer(
          (_) async => throw Exception('Failed to search the query'));

      //act
      final result = mockApiServices.searchRestaurants("Mel");

      //expect
      expect(result, throwsException);
    });
  });

  group('Post Review', () {
    final response = ReviewsResponse.fromJson({
      "error": false,
      "message": "success",
      "customerReviews": [
        {
          "name": "Ahmad",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019"
        },
      ]
    });
    test('post review restaurant data successfully', () async {
      //Arrange atur response mock
      const review = "Test";
      const name = "Test Reihan";

      when(mockApiServices.postReviews(review, name, "rqdv5juczeskfw1e867"))
          .thenAnswer((_) async => Future.value(response));

      //act
      final result = await mockApiServices.postReviews(
          review, name, "rqdv5juczeskfw1e867");

      //expect
      expect(result, const TypeMatcher<ReviewsResponse>());
    });

    test('post review restaurant return throw Exception', () async {
      //Arrange atur response mock
      const review = "Test";
      const name = "Test Reihan";

      when(mockApiServices.postReviews(review, name, "rqdv5juczeskfw1e867"))
          .thenAnswer((_) async => throw Exception("Failed to add review"));

      //act
      final result = mockApiServices.postReviews(
          review, name, "rqdv5juczeskfw1e867");

      //expect
      expect(result, throwsException);
    });
  });
}
