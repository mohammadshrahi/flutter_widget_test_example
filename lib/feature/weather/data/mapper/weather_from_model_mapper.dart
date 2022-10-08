import 'package:weather_widget_test_app/core/mapper.dart';
import 'package:weather_widget_test_app/feature/weather/data/weather_model.dart';
import 'package:weather_widget_test_app/feature/weather/domain/entity/weather.dart';

class WeatherFromModelMapper extends Mapper<Weather, WeatherModel> {
  @override
  Weather call(WeatherModel p) {
    return Weather(
      humidity: p.humidity,
      pressure: p.pressure,
      temperature: p.temperature,
      weatherIcon: p.icons.isEmpty ? '' : p.icons.first,
      visibility: p.visibility,
    );
  }
}
