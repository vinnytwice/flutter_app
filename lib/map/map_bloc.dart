import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_app/map/map_event.dart';
import 'package:flutter_app/map/map_state.dart';
import 'package:flutter_app/map/map_repository.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository;
//  LatLng location;
  LatLng locationStream;
  StreamSubscription _locationStreamSubscription;

  MapBloc({@required MapRepository mapRepository})
      : assert(mapRepository != null), // || streamSubscription != null),
        _mapRepository = mapRepository;

  MapState get initialState => LocationStream(locationStream);

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    // user location
    if (event is GetLocationStream) {
//      print('MapBloc event received : $event');
      yield* _mapGetLocationStreamToState(event);
    }
    if (event is LocationUpdated) {
      yield* _mapLocationUpdatedToState(event);
    }
  }

  Stream<MapState> _mapGetLocationStreamToState(
      GetLocationStream event) async* {
//    print('_mapGetLocationStreamToState event received : $event');

    _locationStreamSubscription =
        _mapRepository.getLocationStream().listen((LatLng location) {
      locationStream = location;
      add(LocationUpdated(locationStream));
      print(
          '_mapGetLocationStreamToState() locationStream is: $locationStream ');
    });

//    yield LocationStream(locationStream);
  }

  Stream<MapState> _mapLocationUpdatedToState(LocationUpdated event) async* {
    yield LocationStream(locationStream);
  }
//  Stream<MapState> _mapCenterMapToState(CenterMap event) async* {
//    _mapRepository.getLocation();
////    (location) => add(LocationUpdated(location));
//    // CANT GET LOCATION TO PASS IN MapLoaded()
//    print('_mapCenterMapToState location is : ${_mapRepository.getLocation()}');
//    yield MapCentered(location, locationStream);
//  }

//  Stream<MapState> _mapGetLocationStreamToStateOld(
//      GetLocationStream event) async* {
//    print(
//        '_mapGetLocationStreamToState latitute : ${_mapRepository.getLocationStream().latitude}');
//    print(
//        '_mapGetLocationStreamToState longitute : ${_mapRepository.getLocationStream().longitude}');
//    locationStream = LatLng(_mapRepository.getLocationStream().latitude,
//        _mapRepository.getLocationStream().longitude);
//    print('_mapGetLocationStreamToState() locationStream is: $locationStream ');
//    yield LocationStream(locationStream);
//  }

}
