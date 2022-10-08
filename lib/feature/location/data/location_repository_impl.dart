import 'package:weather_widget_test_app/feature/location/data/location_data_source.dart';
import 'package:weather_widget_test_app/feature/location/domain/entity.dart/current_location.dart';
import 'package:weather_widget_test_app/feature/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  LocationRepositoryImpl({required this.locationDataSource});
  final LocationDataSource locationDataSource;

  @override
  Future<CurrentLocation> getCurrentLocation() {
    return locationDataSource.getCurrentLocation();
  }
}
