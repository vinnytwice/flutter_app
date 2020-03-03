import 'dart:async';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:flutter_map/flutter_map.dart';

class MapRepository {
  bool isTracking = false;
  final locationManager = Geolocator();
  StreamSubscription _positionStreamSubsciption;

  Future<LatLng> getLocation() async {
    print('getLocation() called');
    Position position;
    LatLng location;
    try {
      position = await locationManager
          .getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation)
          .timeout(Duration(seconds: 5));
      location = LatLng(position.latitude, position.longitude);
      print('getLocation() location is: $location');
      return location;
    } catch (error) {
      print(
          'getLocation(): error getting current location: ${error.toString()}');
    }
  }

  Stream<LatLng> getLocationStream() {
    print('getLocationStream() called');
    print('isTracking was : $isTracking');
    Stream<LatLng> locationStream;
    Stream<Position> _positionStream;
    LocationOptions locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0);
    try {
      if (isTracking == true) {
        _positionStreamSubsciption.cancel();
      } else {
        _positionStream = locationManager.getPositionStream(locationOptions);

        handleData(Position position, EventSink<LatLng> sink) =>
            sink.add(LatLng(position.latitude, position.longitude));

        final transformer = StreamTransformer<Position, LatLng>.fromHandlers(
            handleData: handleData);
        locationStream = _positionStream.transform(transformer);
        return locationStream;
      }

      isTracking = !isTracking;
      print('isTracking is : $isTracking');
    } catch (error) {
      print('startTracking error: $error');
    }
  }

//  Future<LatLng> getLocationStream() async {
//    print('getLocationStream() called');
//    print('isTracking was : $isTracking');
//    LatLng location;
//    LocationOptions locationOptions = LocationOptions(
//        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0);
//    try {
//      if (isTracking == true) {
//        _positionStreamSubsciption.cancel();
////        isTracking = !isTracking;
////        print('isTracking was ${!isTracking} and now is : $isTracking');
//      } else {
//        _positionStreamSubsciption = locationManager
//            .getPositionStream(locationOptions)
//            .listen((Position position) {
//          if (position != null) {
//            location = LatLng(position.latitude, position.longitude);
////            return location; // stops the stream
//          }
//          print('getLocationStream() location is : $location');
//          return location; //returns null
//        });
////        return location as Future<LatLng>; //returns null
//
//      }
//
//      isTracking = !isTracking;
//      print('isTracking is : $isTracking');
////      return location as Future<LatLng>; // returns null
//    } catch (error) {
//      print('startTracking error: $error');
//    }
////    return location as Future<LatLng>; // returns null
//  }

//  LatLng getLocationStream() {
//    print('getLocationStream() called');
//    LatLng location;
//    LocationOptions locationOptions = LocationOptions(
//        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0);
//    try {
//      if (isTracking == true) {
//        _positionStreamSubsciption.cancel();
//        isTracking = !isTracking;
//      } else {
//        _positionStreamSubsciption = locationManager
//            .getPositionStream(locationOptions)
//            .listen((Position position) {
//          if (position != null) {
//            location = LatLng(position.latitude, position.longitude);
////            return location; // stops the stream
//          }
//          isTracking = !isTracking;
//          print('getLocationStream() location is : $location');
////          return location; // returns null
//        });
////        return location; // returns null
//      }
////      return location; // returns null
//    } catch (error) {
//      print('startTracking error: $error');
//    }
//    return location; // returns null
//  }

// end
}
