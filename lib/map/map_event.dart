import 'package:latlong/latlong.dart';

abstract class MapEvent {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class GetLocationStream extends MapEvent {}

//class CenterMap extends MapEvent {}

class LocationUpdated extends MapEvent {
  final LatLng updatedLocation;
  const LocationUpdated(this.updatedLocation);
  @override
  List<Object> get props => [updatedLocation];

//  @override
//  String toString() => 'LocationUpdated { updtaded location: $updatedLocation}';
}

//class UpdateLocation extends MapEvent {
//  final LatLng location;
//  const UpdateLocation(this.location);
//  @override
//  List<Object> get props => [location];
//
//  @override
//  String toString() => 'UpdateLocation { updtaded location: $location}';
//}
