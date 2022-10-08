// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:weather_widget_test_app/feature/location/domain/entity.dart/current_location.dart';
import 'package:weather_widget_test_app/feature/location/domain/use_case/get_current_city.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  GetCurrentLocation getCurrentLocation;
  LocationCubit({required this.getCurrentLocation}) : super(LocationInitial());

  void findLoaction() async {
    final res = await getCurrentLocation();

    emit(LocationSuccessState(currentLocation: res));
  }
}
