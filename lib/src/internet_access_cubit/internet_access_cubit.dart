import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fconnectivity/src/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_access_state.dart';

/// Cubit that manages the internet access state of the device.
///
/// This cubit listens for connectivity changes and periodically checks
/// for internet access, emitting the appropriate [InternetAccessState].
class InternetAccessCubit extends Cubit<InternetAccessState> {
  InternetAccessCubit._() : super(const HasInternetAccess()) {
    _createInternetAccessCheckerTimer(_defaultInternetAccessCheckInterval);
    _registerConnectivityListener(_defaultPostConnectivityChangeCheckInterval);
  }

  /// The singleton [InternetAccessCubit] instance.
  static final instance = InternetAccessCubit._();

  /// The interval between periodic internet access checks.
  static const Duration _defaultInternetAccessCheckInterval =
      Duration(minutes: 1);

  /// The interval between the connectivity change and the internet access
  /// check after the change.
  static const Duration _defaultPostConnectivityChangeCheckInterval =
      Duration(seconds: 2);

  /// Timer that triggers periodic internet access checks.
  Timer? _internetAccessCheckerTimer;

  /// Subscription to connectivity changes.
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Completer used to handle concurrent internet access checks.
  Completer<bool>? _hasInternetAccessCompleter;

  /// Sets a new interval for periodic internet access checks.
  ///
  /// Cancels the existing timer and sets up a new one with the provided
  /// [duration].
  void setInternetAccessCheckInterval(Duration duration) {
    _internetAccessCheckerTimer?.cancel();
    _createInternetAccessCheckerTimer(duration);
  }

  /// Sets the delay that is used after a connectivity change before the
  /// internet access check is performed.
  void setPostConnectivityChangeCheckDelay(Duration duration) {
    _connectivitySubscription?.cancel();
    _registerConnectivityListener(duration);
  }

  /// Manually triggers an internet access check and emits the result.
  Future<void> triggerInternetAccessCheck() async =>
      _emitInternetAccessCheckResultingState();

  /// Sets up the periodic timer for internet access checks.
  ///
  /// The timer will call the internet access check immediately and then
  /// at the specified interval.
  void _createInternetAccessCheckerTimer(Duration duration) {
    _internetAccessCheckerTimer = createPeriodicTimer(
      period: duration,
      callback: (timer) async => _emitInternetAccessCheckResultingState(),
      fireImmediately: true,
    );
  }

  /// Sets up a listener for connectivity changes.
  ///
  /// This listener will wait for a short duration before checking the
  /// internet access to allow the network to stabilize.
  void _registerConnectivityListener(Duration delay) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (_) async {
        await Future<void>.delayed(delay);
        await _emitInternetAccessCheckResultingState();
      },
    );
  }

  /// Emits the internet access state based on the result of the internet check.
  Future<void> _emitInternetAccessCheckResultingState() async =>
      emit(await _getInternetCheckResultingState());

  /// Performs an internet check and returns the appropriate
  /// [InternetAccessState].
  Future<InternetAccessState> _getInternetCheckResultingState() async =>
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
  ///
  /// This method attempts to determine if there is an active internet
  /// access and completes the [Completer] with the result.
  Future<void> _startInternetCheck() async {
    try {
      final hasInternetAccess = await InternetConnection().hasInternetAccess;
      _hasInternetAccessCompleter!.complete(hasInternetAccess);
    } catch (_) {
      _hasInternetAccessCompleter!.complete(false);
    } finally {
      _hasInternetAccessCompleter = null;
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _internetAccessCheckerTimer?.cancel();
    return super.close();
  }
}
