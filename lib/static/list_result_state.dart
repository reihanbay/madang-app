import 'package:madang_app/data/model/restaurant_list_response.dart';

sealed class ListResultState {}

class ListResultNoneState extends ListResultState {}
class ListResultLoadingState extends ListResultState {}
class ListResultLoadedState extends ListResultState {
  final List<Restaurants> data;

  ListResultLoadedState(this.data);
}

class ListResultErrorState extends ListResultState {
  final String error;
  ListResultErrorState(this.error);
}