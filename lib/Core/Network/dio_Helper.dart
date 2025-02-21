import 'package:dio/dio.dart';
import 'package:weatherapp/Core/Utilities/Strings.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
        },
      ),
    );
  }

  static Future<Response> getWeatherData({
    required String location,
    required int days,
    required int hour,
    required String apiKey,
  }) async {
    return await dio.get(
      'forecast.json',
      queryParameters: {
        'q': location,
        'days': days,
        'hour': hour,
        'key': apiKey,
      },
    );
  }


}