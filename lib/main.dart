import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/map/map_repository.dart';
import 'package:flutter_app/map/map_bloc.dart';
import 'package:flutter_app/map/map_event.dart';
import 'package:flutter_app/map/map_state.dart';
import 'package:flutter_app/simple_bloc_delegate.dart';
import 'package:flutter_app/screens/map_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  final MapRepository mapRepository = MapRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(create: (context) {
          return MapBloc(
            mapRepository: mapRepository,
          )..add(GetLocationStream());
        }),
//        BlocProvider<AlertBloc>(create: (context) {
//          return AlertBloc(
//            alertRepository: alertRepository,
//          )..add(LoadAlerts());
//        }),
      ],
      child: App(
        mapRepository: mapRepository,
//        alertRepository: alertRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final MapRepository _mapRepository;
//  final AlertRepository _alertRepository;

  App({Key key, @required MapRepository mapRepository}) //,
//      @required AlertRepository alertRepository})
      : assert(MapRepository != null),
        _mapRepository = mapRepository,
//        _alertRepository = alertRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          BlocProvider.of<MapBloc>(context).add(GetLocationStream());
          return MapScreen(name: null, mapRepository: _mapRepository);
        },
      ),
    );
  }
}
