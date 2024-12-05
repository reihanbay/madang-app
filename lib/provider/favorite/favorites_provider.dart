import 'package:flutter/foundation.dart';
import 'package:madang_app/data/local/local_database_service.dart';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';

class FavoritesProvider extends ChangeNotifier{
  final LocalDatabaseService _service;

  FavoritesProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurants>? _restaurantList;
  List<Restaurants>? get list => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> setRestaurant(Restaurant value) async {
    try {
      debugPrint(value.pictureId);
      final result = await _service.insertItem(value);

      final isError = result;

      if(isError) {
        _message = "Failed to save restaurant";
        notifyListeners();
      } else {
        _message = "Success save restaurant!";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save restaurant";
      notifyListeners();
    }
  }

  Future<void> getAllFavorite() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = "All your restaurant is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed get restaurant";
      notifyListeners();
    }
  }

  Future<void> getDetailRestaurant(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Restaurant is loaded";
      notifyListeners();
    } catch(e) {
      debugPrint("asdasda err ${e}");
      _message = "Failed get restaurant";
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Data removed";
      _restaurant = null;
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove data";
      notifyListeners();
    }
  }

  bool checkItemBookmark(String id) {
    final isSameItem = _restaurant?.id == id;
    return isSameItem;
  }

}