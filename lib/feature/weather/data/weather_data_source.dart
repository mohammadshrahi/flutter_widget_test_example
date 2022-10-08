import 'package:weather_widget_test_app/core/app_http_client.dart';
import 'package:weather_widget_test_app/feature/weather/data/weather_model.dart';

abstract class WeatherDataSource {
  Future<WeatherModel> getWeatherModel(String query);
}

class WeatherDataSourceImpl extends WeatherDataSource {
  WeatherDataSourceImpl(this.httpClient);
  HttpClient httpClient;
  @override
  Future<WeatherModel> getWeatherModel(String query) async {
    try {
      final response = await httpClient.get(
          'http://api.weatherstack.com/current?access_key=9be07acec65f103d389340b9b2e010e8&query=$query');
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('StatusCode is ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
