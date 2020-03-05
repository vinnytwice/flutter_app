part of 'map_bloc.dart';

abstract class MapState {
  const MapState();
}

class LocationStream extends MapState {
  final LatLng location;

  const LocationStream(this.location);

  factory LocationStream.initial() {
    return LocationStream(LatLng(0, 0));
  }

  @override
  String toString() => 'LocationStream {location: $location}';
}

class MapLoading extends MapState {
  final LatLng location;

  const MapLoading(this.location);

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
