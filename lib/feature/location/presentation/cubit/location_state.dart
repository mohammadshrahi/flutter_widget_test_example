part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationSuccessState extends LocationState {
  LocationSuccessState({required this.currentLocation});
  final CurrentLocation currentLocation;
}
