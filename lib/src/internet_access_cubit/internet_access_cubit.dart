import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fconnectivity/src/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_access_state.dart';

/// Cubit that manages the internet access state of the device.
class InternetAccessCubit extends Cubit<InternetAccessState> {
  /// Creates an [InternetAccessCubit] instance.
  ///
  /// Initializes with [HasInternetAccess] state and sets up periodic connection
  /// checks and connectivity listener.
  InternetAccessCubit() : super(const HasInternetAccess()) {
    _setupConnectionCheckerTimer();
    _setupConnectivityListener();
  }

  /// The interval between periodic internet connection checks.
  Duration _connectionCheckInterval = const Duration(minutes: 1);

  /// Timer that triggers periodic internet connection checks.
  late Timer _connectionCheckerTimer;

  /// Subscription to connectivity changes.
  late final StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription;

  /// Completer used to handle concurrent internet access checks.
  Completer<bool>? _hasInternetAccessCompleter;

  /// Sets a new interval for periodic internet connection checks.
  ///
  /// Cancels the existing timer and sets up a new one with the provided
  /// [duration].
  void setConnectionCheckInterval(Duration duration) {
    _connectionCheckInterval = duration;
    _connectionCheckerTimer.cancel();
    _setupConnectionCheckerTimer();
  }

  /// Manually triggers an internet access check and emits the result.
  Future<void> checkInternetAccess() async =>
      emit(await _getInternetCheckResult());

  /// Sets up the periodic timer for internet connection checks.
  void _setupConnectionCheckerTimer() {
    _connectionCheckerTimer = createPeriodicTimer(
      period: _connectionCheckInterval,
      callback: (timer) async => emit(await _getInternetCheckResult()),
      fireImmediately: true,
    );
  }

  /// Sets up a listener for connectivity changes.
  void _setupConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (connectivityResultList) async {
        // Add a small delay before checking internet to give the network time
        // to stabilize
        await Future<void>.delayed(const Duration(seconds: 2));
        emit(await _getInternetCheckResult());
      },
    );
  }

  /// Performs an internet check and returns the appropriate
  /// [InternetAccessState].
  Future<InternetAccessState> _getInternetCheckResult() async =>
      switch (await _hasInternetAccess()) {
        true => const HasInternetAccess(),
        false => const HasNoInternetAccess(),
      };

  /// Checks if the device has internet access.
  ///
  /// Uses a [Completer] to handle concurrent calls efficiently.
  Future<bool> _hasInternetAccess() async {
    if (_hasInternetAccessCompleter == null) {
      _hasInternetAccessCompleter = Completer<bool>();
      unawaited(_startInternetCheck());
    }
    return _hasInternetAccessCompleter!.future;
  }

  /// Starts the actual internet check process.
  Future<void> _startInternetCheck() async {
    try {
      final hasConnection = await InternetConnection().hasInternetAccess;
      _hasInternetAccessCompleter!.complete(hasConnection);
    } catch (_) {
      _hasInternetAccessCompleter!.complete(false);
    } finally {
      _hasInternetAccessCompleter = null;
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    _connectionCheckerTimer.cancel();
    return super.close();
  }
}
