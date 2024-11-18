
import 'package:madang_app/data/model/restaurant_detail_response.dart';

sealed class DetailResultState {}

class DetailResultNoneState extends DetailResultState {}

class DetailResultLoadingState extends DetailResultState {}

class DetailResultLoadedState extends DetailResultState {
  final Restaurant item;

  DetailResultLoadedState(this.item);
}

class DetailResultErrorState extends DetailResultState {
  final String error;

  DetailResultErrorState(this.error);
}