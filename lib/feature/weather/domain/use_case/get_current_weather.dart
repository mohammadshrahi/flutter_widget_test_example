import 'package:weather_widget_test_app/core/use_case.dart';
import 'package:weather_widget_test_app/feature/weather/domain/entity/weather.dart';
import 'package:weather_widget_test_app/feature/weather/domain/repository/weather_repository.dart';

class GetCurrentWeather extends UseCase<GetCurrentWeatherParams, Weather> {
  GetCurrentWeather({required this.weatherRepository});
  WeatherRepository weatherRepository;
  @override
  Future<Weather> call(GetCurrentWeatherParams? t) {
    return weatherRepository.getCurrentWeather(t!.query);
  }
}

class GetCurrentWeatherParams {
  GetCurrentWeatherParams({required this.query});
  String query;
}
