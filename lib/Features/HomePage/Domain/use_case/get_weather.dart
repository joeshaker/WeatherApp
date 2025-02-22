import 'package:weatherapp/Features/HomePage/Data/Model/weatherModel.dart';
import 'package:weatherapp/Features/HomePage/Domain/entity/weather_entity.dart';
import 'package:weatherapp/Features/HomePage/Domain/repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<WeatherEntity> execute(String location) async {
    return await repository.getWeather(location);
  }
}