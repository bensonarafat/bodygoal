import 'dart:async';

import 'package:bodygoal/ui/common/services/connectivity_service.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityStatus _connectivityStatus = ConnectivityStatus.unknown;
  StreamSubscription<ConnectivityStatus>? _connectivitySubscription;

  final ConnectivityService _connectivityService = ConnectivityService();

  ConnectivityStatus get connectivityStatus => _connectivityStatus;
  void initialize() {
    _connectivitySubscription =
        _connectivityService.connectionStatus.listen((status) {
      _connectivityStatus = status;
      notifyListeners();
    });
  }

  void retryConnection() async {
    final status = await _connectivityService.checkConnectivity();
    _connectivityStatus = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
