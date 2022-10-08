part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherSuccess extends WeatherState {
  WeatherSuccess(this.weather);

  final Weather weather;
}
