import 'package:weather_widget_test_app/core/use_case.dart';
import 'package:weather_widget_test_app/feature/location/domain/entity.dart/current_location.dart';
import 'package:weather_widget_test_app/feature/location/domain/repository/location_repository.dart';

class GetCurrentLocation extends UseCaseWithoutParams<CurrentLocation> {
  GetCurrentLocation({required this.locationRepository});
  LocationRepository locationRepository;

  @override
  Future<CurrentLocation> call() async {
    return await locationRepository.getCurrentLocation();
  }
}
