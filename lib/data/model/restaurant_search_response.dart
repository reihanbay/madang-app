import 'package:madang_app/data/model/restaurant_list_response.dart';

class SearchRestaurantsResponse {
    bool error;
    int founded;
    List<Restaurant> restaurants;

    SearchRestaurantsResponse({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory SearchRestaurantsResponse.fromJson(Map<String, dynamic> json) => SearchRestaurantsResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}