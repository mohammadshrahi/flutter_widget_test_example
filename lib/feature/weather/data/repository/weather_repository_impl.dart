import 'package:weather_widget_test_app/feature/weather/data/mapper/weather_from_model_mapper.dart';
import 'package:weather_widget_test_app/feature/weather/data/weather_data_source.dart';
import 'package:weather_widget_test_app/feature/weather/domain/entity/weather.dart';
import 'package:weather_widget_test_app/feature/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl({required this.weatherDataSource});
  WeatherDataSource weatherDataSource;

  @override
  Future<Weather> getCurrentWeather(String query) async {
    final weather = WeatherFromModelMapper()(
        await weatherDataSource.getWeatherModel(query));
    return weather;
  }
}
