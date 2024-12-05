import 'package:flutter/material.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/static/detail_result_state.dart';
import 'package:madang_app/static/review_post_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  DetailRestaurantProvider(this._apiServices);

  DetailResultState _resultDetail = DetailResultNoneState();
  DetailResultState get resultDetail => _resultDetail;

  ReviewPostState _resultReview = ReviewPostNoneState();
  ReviewPostState get resultReview => _resultReview;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _resultDetail = DetailResultLoadingState();
      notifyListeners();

      final result = await _apiServices.getDetailRestaurant(id);

      if (result.error) {
        _resultDetail = DetailResultErrorState(result.message);
        notifyListeners();
      } else {
        _resultDetail = DetailResultLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultDetail = DetailResultErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> postReviews(String id, String name, String review) async {
    try {
      _resultReview = ReviewPostLoadingState();
      notifyListeners();

      final result = await _apiServices.postReviews(review, name, id);

      if (result.error) {
        _resultReview = ReviewPostErrorState(result.message);
        notifyListeners();
      } else {
        _resultReview = ReviewPostLoadedState(result.customerReviews);
      }
    } on Exception catch (e) {
      _resultReview = ReviewPostErrorState(e.toString());
      notifyListeners();
    }
  }
}
