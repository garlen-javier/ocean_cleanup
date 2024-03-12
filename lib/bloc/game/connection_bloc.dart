import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/game/connection_event.dart';
import 'package:ocean_cleanup/bloc/game_stats/connection_stats.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(event, emit) {
    SaveUtils.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}
