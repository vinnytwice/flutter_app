import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/map/map_repository.dart';
import 'package:flutter_app/map/map_bloc.dart';
import 'package:flutter_app/simple_bloc_delegate.dart';
import 'package:flutter_app/screens/map_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(create: (context) {
          return MapBloc(
            mapRepository: MapRepository(),
          )..add(GetLocationStream());
        }),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return MapScreen();
        },
      ),
    );
  }
}
