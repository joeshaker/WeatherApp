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
      cloud: response.current.cloud.toDouble(),
      forecastDays: response.forecast.forecastday.map((forecastDay) =>
          ForecastDayEntity(
            date: forecastDay.date,
            maxTempC: forecastDay.day.maxtempC,
            minTempC: forecastDay.day.mintempC,
            avgHumidity: forecastDay.day.avghumidity.toDouble(),
            chanceOfRain: forecastDay.day.dailyChanceOfRain.toDouble(),
          )).toList(),
    );
  }

  @override
  Future<List<int>> getWeatherConditions(WeatherEntity weather) {
    List<int> conditions = [0, 0, 0, 0, 0];

    if (weather.conditionText.toLowerCase().contains("rain")) {
      conditions[0] = 1;
    }

    if (weather.conditionText.toLowerCase().contains("sun")) {
      conditions[1] = 1;
    }

    if (weather.temperatureC > 30) {
      conditions[2] = 1;
    }

    if (weather.temperatureC >= 15 && weather.temperatureC <= 30) {
      conditions[3] = 1;
    }

    if (weather.humidity >= 30 && weather.humidity <= 60) {
      conditions[4] = 1;
    }
    return Future.value(conditions);
  }
}
