class WeatherEntity {
  final String locationName;
  final String region;
  final String country;
  final double temperatureC;
  final double temperatureF;
  final String conditionText;
  final String conditionIcon;
  final double windKph;
  final double humidity;
  final double uvIndex;
  final double pressureMb;
  final double cloud;
  final List<ForecastDayEntity> forecastDays;

  WeatherEntity({
    required this.locationName,
    required this.region,
    required this.country,
    required this.temperatureC,
    required this.temperatureF,
    required this.conditionText,
    required this.conditionIcon,
    required this.windKph,
    required this.humidity,
    required this.uvIndex,
    required this.forecastDays,
    required this.pressureMb,
    required this.cloud,

  });
}

class ForecastDayEntity {
  final String date;
  final double maxTempC;
  final double minTempC;
  final double avgHumidity;
  final double chanceOfRain;

  ForecastDayEntity({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.avgHumidity,
    required this.chanceOfRain,
  });
}

// List<int> getWeatherConditions(WeatherEntity weather) {
//   List<int> conditions = [0, 0, 0, 0, 0];
//
//   if (weather.conditionText.toLowerCase().contains("rain")) {
//     conditions[0] = 1;
//   }
//
//   if (weather.conditionText.toLowerCase().contains("sun")) {
//     conditions[1] = 1;
//   }
//
//   if (weather.temperatureC > 30) {
//     conditions[2] = 1;
//   }
//
//   if (weather.temperatureC >= 15 && weather.temperatureC <= 30) {
//     conditions[3] = 1;
//   }
//
//   if (weather.humidity >= 30 && weather.humidity <= 60) {
//     conditions[4] = 1;
//   }
//
//   return conditions;
// }