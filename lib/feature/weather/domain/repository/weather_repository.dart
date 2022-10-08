import 'package:weather_widget_test_app/feature/weather/domain/entity/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String query);
}
