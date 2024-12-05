import 'package:flutter/material.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/data/model/restaurant_search_response.dart';
import 'package:madang_app/static/list_result_state.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  ListRestaurantProvider(this._apiServices);
  ListResultState _resultList = ListResultNoneState();
  ListResultState get resultList => _resultList;

  Future<void> fetchRestaurants({String query = ""}) async {
    try {
      _resultList = ListResultLoadingState();
      notifyListeners();

      dynamic result;
      if (query.isEmpty) {
        result = await _apiServices.getRestaurants();
        result as RestaurantsResponse;
        if (result.error) {
          _resultList = ListResultErrorState(result.message);
          notifyListeners();
        } else {
          _resultList = ListResultLoadedState(result.restaurants);
          notifyListeners();
        }
      } else {
        result = await _apiServices.searchRestaurants(query);
        result as SearchRestaurantsResponse;
        if (result.founded == 0) {
          _resultList = ListResultErrorState("Not Found");
          notifyListeners();
        } else {
          _resultList = ListResultLoadedState(result.restaurants);
          notifyListeners();
        }
      }
    } on Exception catch (e) {
      _resultList = ListResultErrorState(e.toString());
      notifyListeners();
    }
  }
}
