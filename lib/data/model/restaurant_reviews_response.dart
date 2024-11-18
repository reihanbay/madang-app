// To parse this JSON data, do
//
//     final reviewsResponse = reviewsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:madang_app/data/model/restaurant_detail_response.dart';

ReviewsResponse reviewsResponseFromJson(String str) => ReviewsResponse.fromJson(json.decode(str));

String reviewsResponseToJson(ReviewsResponse data) => json.encode(data.toJson());

class ReviewsResponse {
    bool error;
    String message;
    List<CustomerReview> customerReviews;

    ReviewsResponse({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory ReviewsResponse.fromJson(Map<String, dynamic> json) => ReviewsResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}


