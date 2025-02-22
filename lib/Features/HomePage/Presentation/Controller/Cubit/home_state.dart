part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {
final WeatherEntity response;
HomeSuccess(this.response);
}
final class HomeError extends HomeState {
  final String error;
  final String error_message;

  HomeError(this.error, this.error_message) {
  }
}
