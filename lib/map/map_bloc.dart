import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_app/map/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository;
  StreamSubscription _locationStreamSubscription;

  MapBloc({@required MapRepository mapRepository})
      : assert(mapRepository != null),
        _mapRepository = mapRepository;

  MapState get initialState => LocationStream.initial();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is GetLocationStream) {
      yield* _mapGetLocationStreamToState(event);
    } else if (event is LocationUpdated) {
      yield* _mapLocationUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _locationStreamSubscription?.cancel();
    return super.close();
  }

  Stream<MapState> _mapGetLocationStreamToState(
    GetLocationStream event,
  ) async* {
    _locationStreamSubscription?.cancel();
    _locationStreamSubscription = _mapRepository.getLocationStream().listen(
      (LatLng location) {
        add(LocationUpdated(location));
      },
    );
  }

  Stream<MapState> _mapLocationUpdatedToState(LocationUpdated event) async* {
    yield LocationStream(event.updatedLocation);
  }
}
