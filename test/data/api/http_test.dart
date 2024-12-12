import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/data/model/restaurant_reviews_response.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'http_test.mocks.dart';
import 'response_dummy.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ApiServices apiServices;
  const baseUrl = "https://restaurant-api.dicoding.dev";

  setUp(() {
    mockClient = MockClient();
    apiServices = ApiServices(client: mockClient);
  });
  group('fetch Restaurants', () {
    test('return an Restaurants if http call success', () async {
      //arange
      const url = "$baseUrl/list";
      String responseData = responseRestaurant();
      when(mockClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response(responseData, 200));

      //act
      final result = await apiServices.getRestaurants();

      //assert
      expect(result, const TypeMatcher<RestaurantsResponse>());
    });

    test('return throwException when http notFound', () async {
      //arange
      const url = "$baseUrl/list";
      when(mockClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response("""{
  "error": true,
  "message": "Not Found"
}""", 404));

      //act
      final result = apiServices.getRestaurants();
      print(result);

      //assert
      expect(result, throwsException);
    });

    group('fetch getDetail Restaurant', () {
      test('return a Detail Restaurants if http call success', () async {
        //arange
        final String response = responseDetailRestaurant();
        when(mockClient.get(Uri.parse("$baseUrl/detail/rqdv5juczeskfw1e867")))
            .thenAnswer((_) async => http.Response(response, 200));

        //act
        final result =
            await apiServices.getDetailRestaurant("rqdv5juczeskfw1e867");

        //assert
        expect(result, const TypeMatcher<DetailRestaurantResponse>());
        verify(mockClient.get(Uri.parse("$baseUrl/detail/rqdv5juczeskfw1e867")))
            .called(1);
      });

      test('return throwException when http notFound', () async {
        //arange
        when(mockClient.get(Uri.parse("$baseUrl/detail/rqdv5juczeskfw1e867")))
            .thenAnswer((_) async => http.Response("""{
          "error": true,
          "message": "Restaurant not found"
        }""", 404));

        //act
        final result = apiServices.getDetailRestaurant("rqdv5juczeskfw1e867");

        //assert
        expect(result, throwsException);
        verify(mockClient.get(Uri.parse("$baseUrl/detail/rqdv5juczeskfw1e867")))
            .called(1);
      });
    });

    group('post review', () {
      test('return ReviewResponse when http success', () async {
        //arange
        const url = "$baseUrl/review";
        const id = "rqdv5juczeskfw1e867";
        const name = "test";
        const review = "test";
        String response = responsePostReview();
        when(mockClient.post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'id': id,
              'name': name,
              'review': review
            }))).thenAnswer((_)async => http.Response(response, 200));

        //act
        final result = await apiServices.postReviews(review, name, id);

        //assert
        expect(result, TypeMatcher<ReviewsResponse>());
      });
    });
  });
}
