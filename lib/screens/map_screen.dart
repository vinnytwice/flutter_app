import 'package:flutter_app/map/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is LocationStream) {
              return _Map(location: state.location);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class _Map extends StatefulWidget {
  const _Map({Key key, @required this.location}) : super(key: key);

  final LatLng location;

  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<_Map> {
  final MapController _mapController = MapController();

  LatLng get _location => widget.location;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  center: _location,
                  minZoom: 5.0,
                  maxZoom: 19.0,
                ),
                mapController: _mapController,
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          'https://api.openrouteservice.org/mapsurfer/{z}/{x}/{y}.png?api_key=5b3ce3597851110001cf62484c4b65d85bc844eca3a2c6b9f300ddf4',
                      subdomains: ['a', 'b', 'c'],
                      keepBuffer: 20),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        point: _location,
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
                    _mapController.move(_location, 16);
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {},
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
    );
  }
}
