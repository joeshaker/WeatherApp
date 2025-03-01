import 'package:weatherapp/Features/HomePage/Data/Model/weatherModel.dart';
import 'package:weatherapp/Features/HomePage/Domain/entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather(String location);
  Future<List<int>> getWeatherConditions(WeatherEntity weather);
}