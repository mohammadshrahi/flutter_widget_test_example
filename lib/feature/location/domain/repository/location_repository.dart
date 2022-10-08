import 'package:weather_widget_test_app/feature/location/domain/entity.dart/current_location.dart';

abstract class LocationRepository {
  Future<CurrentLocation> getCurrentLocation();
}
