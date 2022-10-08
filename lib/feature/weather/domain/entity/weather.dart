class Weather {
  const Weather({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.weatherIcon,
  });
  final String temperature;
  final String pressure;

  final String humidity;
  final String visibility;
  final String weatherIcon;
}
