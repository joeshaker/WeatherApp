import 'package:dio/dio.dart';
import 'package:weatherapp/Core/Network/dio_helper.dart';
import 'package:weatherapp/Features/HomePage/Data/Model/weatherModel.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> getWeather(String location);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final DioHelper dioHelper;
  final String apiKey;

  WeatherRemoteDataSourceImpl({required this.dioHelper, required this.apiKey});

  @override
  Future<WeatherResponse> getWeather(String location) async {
    try {
      final response = await DioHelper.getWeatherData(
        location: location,
        days: 3,
        hour: 24,
        apiKey: apiKey,
      );

      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}