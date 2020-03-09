part of 'map_bloc.dart';

abstract class MapEvent {
  const MapEvent();
}

class GetLocationStream extends MapEvent {}

class LocationUpdated extends MapEvent {
  final LatLng updatedLocation;
  const LocationUpdated(this.updatedLocation);
}
