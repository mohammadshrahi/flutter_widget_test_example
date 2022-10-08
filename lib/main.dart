import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_widget_test_app/core/app_http_client.dart';
import 'package:weather_widget_test_app/feature/location/data/location_data_source.dart';
import 'package:weather_widget_test_app/feature/location/data/location_repository_impl.dart';
import 'package:weather_widget_test_app/feature/location/domain/entity.dart/current_location.dart';
import 'package:weather_widget_test_app/feature/location/domain/use_case/get_current_city.dart';
import 'package:weather_widget_test_app/feature/location/presentation/cubit/location_cubit.dart';
import 'package:weather_widget_test_app/feature/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_widget_test_app/feature/weather/data/weather_data_source.dart';
import 'package:weather_widget_test_app/feature/weather/domain/use_case/get_current_weather.dart';
import 'package:weather_widget_test_app/feature/weather/presentation/cubit/weather_cubit.dart';

void main() {
  runApp(BlocsWidget(
    locationDataSource: LocationDataSourceImpl(),
    httpClient: AppHttpClient(Dio()),
    child: const MyApp(),
  ));
}

class BlocsWidget extends StatefulWidget {
  const BlocsWidget(
      {super.key,
      required this.child,
      required this.httpClient,
      required this.locationDataSource});
  final Widget child;
  final HttpClient httpClient;
  final LocationDataSource locationDataSource;

  @override
  State<BlocsWidget> createState() => _BlocsWidgetState();
}

class _BlocsWidgetState extends State<BlocsWidget> {
  late LocationCubit locationCubit;
  late WeatherCubit weatherCubit;
  @override
  void initState() {
    _locationCubitInit();
    _weatherCubitInit();

    super.initState();
  }

  void _weatherCubitInit() {
    final weatherDataSource = WeatherDataSourceImpl(widget.httpClient);
    final weatherRepositoryImpl =
        WeatherRepositoryImpl(weatherDataSource: weatherDataSource);
    final getCurrentWeather =
        GetCurrentWeather(weatherRepository: weatherRepositoryImpl);
    weatherCubit = WeatherCubit(getCurrentWeather: getCurrentWeather);
  }

  void _locationCubitInit() {
    final locationRepository =
        LocationRepositoryImpl(locationDataSource: widget.locationDataSource);
    final getCurrentLocation =
        GetCurrentLocation(locationRepository: locationRepository);
    locationCubit = LocationCubit(getCurrentLocation: getCurrentLocation);
    locationCubit.findLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LocationCubit>.value(value: locationCubit),
      BlocProvider<WeatherCubit>.value(value: weatherCubit)
    ], child: widget.child);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class AppBackGround extends StatelessWidget {
  const AppBackGround({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/weather.webp',
              ))),
      child: child,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackGround(
          child: BlocListener<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state is LocationSuccessState) {
                BlocProvider.of<WeatherCubit>(context)
                    .getWeather(state.currentLocation);
              }
            },
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationSuccessState) {
                  return WeatherWidget(currentLocation: state.currentLocation);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.currentLocation,
  });

  final CurrentLocation currentLocation;

  @override
  Widget build(Object context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      currentLocation.city,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 34),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TitledText(
                        title: 'Humidity', value: state.weather.humidity),
                    const SizedBox(
                      height: 10,
                    ),
                    TitledText(
                        title: 'Pressure', value: state.weather.pressure),
                    const SizedBox(
                      height: 10,
                    ),
                    TitledText(
                        title: 'Temperature', value: state.weather.temperature),
                    const SizedBox(
                      height: 10,
                    ),
                    TitledText(
                        title: 'Visibility', value: state.weather.visibility),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class TitledText extends StatelessWidget {
  const TitledText({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title: $value',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
