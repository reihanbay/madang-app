import 'package:madang_app/data/model/restaurant_detail_response.dart';

sealed class ReviewPostState {}

class ReviewPostNoneState extends ReviewPostState {}
class ReviewPostLoadingState extends ReviewPostState {}
class ReviewPostLoadedState extends ReviewPostState {
  final List<CustomerReview> response;

  ReviewPostLoadedState(this.response);
}
class ReviewPostErrorState extends ReviewPostState {
final String error;
  ReviewPostErrorState(this.error);
}