import 'dart:async';
//import 'package:fixit_cloud_biking/alerts/alert_bloc.dart';
//import 'package:fixit_cloud_biking/alerts/alert_event.dart';
//import 'package:fixit_cloud_biking/alerts/alerts_repository.dart';
//import 'package:fixit_cloud_biking/alerts/bloc.dart';
//import 'package:fixit_cloud_biking/alerts/firebase_repository.dart';
import 'package:flutter_app/map/map_bloc.dart';
import 'package:flutter_app/map/map_event.dart';
import 'package:flutter_app/map/map_state.dart';
import 'package:flutter_app/map/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';

// newer .. working?

class MapScreen extends StatelessWidget {
  final String name;
  final MapRepository _mapRepository;
  final MapController _mapController;
//  final AlertRepository _alertRepository;
  List<Marker> alerts;
  LatLng userLocation;
  MapScreen(
      {Key key, @required this.name, @required MapRepository mapRepository})
      : assert(mapRepository != null),
        _mapRepository = mapRepository,
        _mapController = MapController(),
//        _alertRepository = alertRepository,
        super(key: key);

  // v1: "lift the creation of the Map Bloc to a parent widget"
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
//        bloc: MapBloc(mapRepository: _mapRepository),
        builder: (BuildContext context, MapState state) {
      userLocation = (state as LocationStream).location;
//      if (state is LocationStream) {
//        userLocation = (state).location;
//      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Home',
            style: TextStyle(color: Colors.orangeAccent, fontSize: 40),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.orange,
                size: 35,
              ),
              onPressed: () {
//                BlocProvider.of<AuthenticationBloc>(context).add(
//                  LoggedOut(),
//                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 570,
                  width: 320,
                  child: FlutterMap(
                    options: MapOptions(
                      center: userLocation,
                      minZoom: 5.0,
                      maxZoom: 19.0,
                    ),
                    mapController: _mapController,
                    layers: [
                      //
//        PolygonLayer(polygonOpts, map, stream)
//                    PolygonLayerOptions(
//                      polygons:
//                    ),
                      TileLayerOptions(
                          urlTemplate:
                              'https://api.openrouteservice.org/mapsurfer/{z}/{x}/{y}.png?api_key=5b3ce3597851110001cf62484c4b65d85bc844eca3a2c6b9f300ddf4',
//                              urlTemplate:
//                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                          keepBuffer: 20),
                      new MarkerLayerOptions(
                        markers: [
                          Marker(
                            point: userLocation,
                            height: 200,
                            width: 200,
                            builder: (context) => IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 60,
                              onPressed: () {
                                print('icon tapped');
                              },
                            ),
                          ),
//                          Marker(
//                            height: ,
//                            builder: BlocBuilder<AlertBloc,AlertState>(
//                                builder: (BuildContext context, AlertState state) {
//                                  alerts = (state as AlertsUpdated).alerts;
//                                  return
//                                }),
//                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        print(
                            ' @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   userLocation is $userLocation');
                        _mapController.move(userLocation, 16);
                      },
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'center',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        //TODO  this goes actually in a alert icon callbac, here just navigates icons vc
                      },
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'alert',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
