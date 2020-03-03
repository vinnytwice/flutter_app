import 'package:latlong/latlong.dart';
import 'package:flutter_app/map/map_repository.dart';

abstract class MapState {
  const MapState();
  @override
  List<Object> get props => [];
}

class LocationStream extends MapState {
  final LatLng location;

  const LocationStream(this.location);

  @override
  List<Object> get props => [location];

  @override
  String toString() => 'LocationStream {location: $location}';
}

class MapLoading extends MapState {
  final LatLng location;

  const MapLoading(this.location);

  @override
  List<Object> get props => [location];

  @override
  String toString() => 'LocationStream {location: $location}';
}

//class MapCentered extends MapState {
//  final LatLng location;
//  final LatLng locationStream;
//
//  const MapCentered(this.location, this.locationStream);
//
//  @override
//  List<Object> get props => [location, locationStream];
//
//  @override
//  String toString() =>
//      'MapCentered {location: $location, locationStream: $locationStream}';
//}

//class MapNotLoaded extends MapState {}
//
//// Tracking
//
//class getTracking extends MapState {}
