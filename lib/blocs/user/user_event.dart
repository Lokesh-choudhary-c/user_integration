abstract class UserEvent {}

class FetchUsers extends UserEvent {
  final int limit;
  final int skip;

  FetchUsers({this.limit = 20, this.skip = 0});
}

class SearchUsers extends UserEvent {
  final String query;

  SearchUsers({required this.query});
}
