import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/Features/HomePage/Domain/use_case/get_weather.dart';
import 'package:weatherapp/Features/HomePage/Domain/entity/weather_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetWeather getWeather;

  HomeCubit({required this.getWeather}) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  WeatherEntity? response;

  void getWeatherData(String location, int days, int hour, String apiKey) {
    emit(HomeLoading());
    getWeather.execute(location).then((value) {
      response = value;
      emit(HomeSuccess(response!));
    }).catchError((error) {
      emit(HomeError(error.toString(), error.response?.data['message'] ?? ''));
    });
  }
}