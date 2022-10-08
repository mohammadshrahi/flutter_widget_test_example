import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_widget_test_app/feature/location/domain/entity.dart/current_location.dart';
import 'package:weather_widget_test_app/feature/weather/domain/entity/weather.dart';
import 'package:weather_widget_test_app/feature/weather/domain/use_case/get_current_weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  GetCurrentWeather getCurrentWeather;
  WeatherCubit({required this.getCurrentWeather}) : super(WeatherInitial());

  void getWeather(CurrentLocation currentLocation) async {
    try {
      final weather = await getCurrentWeather(
          GetCurrentWeatherParams(query: currentLocation.city));
      emit(WeatherSuccess(weather));
    } catch (e) {
      print(e);
    }
  }
}
