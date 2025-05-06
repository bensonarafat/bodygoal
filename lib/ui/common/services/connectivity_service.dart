import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { wifi, mobile, none, unknown }

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  ConnectivityStatus status = ConnectivityStatus.unknown;

  // Stream to listen to connectivity changes
  Stream<ConnectivityStatus> get connectionStatus async* {
    yield* _connectivity.onConnectivityChanged.map(_getStatusFromResult);
  }

  // Convert ConnectivityResult to our custom ConnectivityStatus
  ConnectivityStatus _getStatusFromResult(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.mobile)) {
      return ConnectivityStatus.mobile;
    } else if (results.contains(ConnectivityResult.wifi)) {
      return ConnectivityStatus.wifi;
    } else if (results.contains(ConnectivityResult.none)) {
      return ConnectivityStatus.none;
    }
    return ConnectivityStatus.unknown;
  }

  // Check current connectivity status
  Future<ConnectivityStatus> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return _getStatusFromResult(result);
  }
}
