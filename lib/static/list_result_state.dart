sealed class ListResultState {}

class ListResultNoneState extends ListResultState {}
class ListResultLoadingState extends ListResultState {}
class ListResultLoadedState<T> extends ListResultState {
  final List<T> data;

  ListResultLoadedState(this.data);
}

class ListResultErrorState extends ListResultState {
  final String error;
  ListResultErrorState(this.error);
}