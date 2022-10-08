import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:weather_widget_test_app/feature/location/data/current_location_model.dart';

abstract class LocationDataSource {
  Future<CurrentLocationModel> getCurrentLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<CurrentLocationModel> getCurrentLocation() async {
    final currentCity = await getUserLocation();
    return CurrentLocationModel(city: currentCity);
  }
}

Future<String> getUserLocation() async {
  try {
    final location = Location();
    final myLocation = await location.getLocation();

    final coordinates = Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first.locality;
  } catch (e) {
    return 'Berlin';
  }
}
