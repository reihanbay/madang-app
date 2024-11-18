import 'package:flutter/material.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/static/detail_result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  DetailRestaurantProvider(this._apiServices);

  DetailResultState _resultDetail = DetailResultNoneState();
  DetailResultState get resultDetail => _resultDetail;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _resultDetail = DetailResultLoadingState();
      notifyListeners();

      final result = await _apiServices.getDetailRestaurant(id);

      if(result.error) {
        _resultDetail = DetailResultErrorState(result.message);
        notifyListeners();
      } else {
        _resultDetail = DetailResultLoadedState(result.restaurant);
        notifyListeners();
      }
    } 
    on Exception catch(e) {
      _resultDetail = DetailResultErrorState(e.toString());
      notifyListeners();
    } 
  }
}