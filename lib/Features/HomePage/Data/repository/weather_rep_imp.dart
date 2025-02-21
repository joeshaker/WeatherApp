import 'package:weatherapp/Features/HomePage/Data/Model/weatherModel.dart';
import 'package:weatherapp/Features/HomePage/Data/data_source/data_source.dart';
import 'package:weatherapp/Features/HomePage/Domain/entity/weather_entity.dart';
import 'package:weatherapp/Features/HomePage/Domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WeatherEntity> getWeather(String location) async {
    final weatherResponse = await remoteDataSource.getWeather(location);
    return _mapWeatherResponseToEntity(weatherResponse);
  }

  WeatherEntity _mapWeatherResponseToEntity(WeatherResponse response) {
    return WeatherEntity(
      locationName: response.location.name,
      region: response.location.region,
      country: response.location.country,
      temperatureC: response.current.tempC,
      temperatureF: response.current.tempF,
      conditionText: response.current.condition.text,
      conditionIcon: response.current.condition.icon,
      windKph: response.current.windKph,
      humidity: response.current.humidity.toDouble(),
      uvIndex: response.current.uv,
      pressureMb: response.current.pressureMb,
      forecastDays: response.forecast.forecastday.map((forecastDay) => ForecastDayEntity(
        date: forecastDay.date,
        maxTempC: forecastDay.day.maxtempC,
        minTempC: forecastDay.day.mintempC,
        avgHumidity: forecastDay.day.avghumidity.toDouble(),
        chanceOfRain: forecastDay.day.dailyChanceOfRain.toDouble(),
      )).toList(),
    );
  }
}