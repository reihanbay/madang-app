import 'package:madang_app/data/model/restaurant_list_response.dart';

class SearchRestaurantsResponse {
  bool error;
  int founded;
  List<Restaurants> restaurants;

  SearchRestaurantsResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantsResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantsResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurants>.from(
            json["restaurants"].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
