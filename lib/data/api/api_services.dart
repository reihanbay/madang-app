
import 'dart:convert';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:madang_app/data/model/restaurant_reviews_response.dart';
import 'package:madang_app/data/model/restaurant_search_response.dart';

class ApiServices {
  http.Client client;
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  ApiServices({required this.client});
  Future<RestaurantsResponse> getRestaurants() async {
    final response = await client.get(Uri.parse("$_baseUrl/list"));

    if(response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final response = await client.get(Uri.parse("$_baseUrl/detail/$id"));

    if(response.statusCode == 200 || response.statusCode == 201) {
      return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load detail");
    }
  }

  Future<SearchRestaurantsResponse> searchRestaurants(String query) async {
    final response = await client.get(Uri.parse('$_baseUrl/search?q=$query'));

    if(response.statusCode == 200 || response.statusCode == 201) {
      return SearchRestaurantsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to search the query");
    }
  }

  Future<ReviewsResponse> postReviews(String review, String name, String id) async {
    final response = await client.post(Uri.parse('$_baseUrl/review'), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<String, String> {
      'id' : id,
      'name' : name,
      'review' : review
      })
    );
    
    if(response.statusCode == 200 || response.statusCode == 201) {
      return ReviewsResponse.fromJson(jsonDecode(response.body)as Map<String, dynamic>);
    } else {
      throw Exception('Failed to add review');
    }
  }
  
  
}