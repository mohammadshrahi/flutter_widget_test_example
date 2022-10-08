class WeatherModel {
  WeatherModel({
    required this.humidity,
    required this.pressure,
    required this.temperature,
    required this.visibility,
    required this.icons,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        humidity: json['current']['humidity'].toString(),
        pressure: json['current']['pressure'].toString(),
        temperature: json['current']['temperature'].toString(),
        visibility: json['current']['visibility'].toString(),
        icons: (json['current']['weather_icons'] as List)
            .map((e) => e.toString())
            .toList());
  }
  final String temperature;
  final String pressure;

  final String humidity;
  final String visibility;
  final List<String> icons;
}
