import 'package:weather_widget_test_app/feature/location/data/current_location_model.dart';
import 'package:weather_widget_test_app/feature/location/data/location_data_source.dart';

class LocationMockDataSource implements LocationDataSource {
  LocationMockDataSource() {
    currentLocationModel = null;
  }
  static CurrentLocationModel? currentLocationModel;
  @override
  Future<CurrentLocationModel> getCurrentLocation() async {
    if (currentLocationModel != null) {
      return currentLocationModel!;
    } else {
      return CurrentLocationModel(city: 'Berlin');
    }
  }

  static setLocationMockData(String city) {
    currentLocationModel = CurrentLocationModel(city: city);
  }
}
