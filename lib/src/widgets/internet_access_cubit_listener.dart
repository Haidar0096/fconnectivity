import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// - isFirstCapturedState:
// ignore: lines_longer_than_80_chars
/// {@template fconnectivity.internet_access_cubit_listener.is_first_captured_state}
/// Whether this is the first state captured by this listener.
/// "First state" does not necessarily means that the cubit has not
/// emitted any state before, but that this listener has not captured
/// any state before.
/// This flag might be useful if you do not want to act (ex: show a
/// snackbar) on the first state captured by this listener, but rather
/// only for the subsequent states.
/// {@endtemplate}
typedef OnHasInternetAccess = void Function({
  required BuildContext context,
  required bool isFirstCapturedState,
});

/// - isFirstCapturedState:
// ignore: lines_longer_than_80_chars
/// {@macro fconnectivity.internet_access_cubit_listener.is_first_captured_state}
typedef OnHasNoInternetAccess = void Function({
  required BuildContext context,
  required bool isFirstCapturedState,
});

/// Widget that listens to the internet access state of the device and calls
/// the appropriate callback based on the state.
class InternetAccessCubitListener extends StatefulWidget {
  /// Creates an [InternetAccessCubitListener] instance.
  const InternetAccessCubitListener({
    required this.child,
    required this.onHasInternetAccess,
    required this.onHasNoInternetAccess,
    super.key,
  });

  /// The child widget to wrap with the listener.
  final Widget child;

  /// Callback function to be called when the device has internet access.
  ///
  /// The callback will be called with the current state and whether it is the
  /// first state captured by this listener.
  final OnHasInternetAccess onHasInternetAccess;

  /// Callback function to be called when the device does not have internet
  /// access.
  ///
  /// The callback will be called with the current state and whether it is the
  /// first state captured by this listener.
  final OnHasNoInternetAccess onHasNoInternetAccess;

  @override
  State<InternetAccessCubitListener> createState() =>
      _InternetAccessCubitListenerState();
}

class _InternetAccessCubitListenerState
    extends State<InternetAccessCubitListener> {
  bool _isFirstCapturedState = false;

  @override
  Widget build(BuildContext context) =>
      BlocListener<InternetAccessCubit, InternetAccessState>(
        listener: (context, internetAccessState) {
          switch (internetAccessState) {
            case HasNoInternetAccess():
              widget.onHasNoInternetAccess(
                context: context,
                isFirstCapturedState: _isFirstCapturedState,
              );
            case HasInternetAccess():
              widget.onHasInternetAccess(
                context: context,
                isFirstCapturedState: _isFirstCapturedState,
              );
          }
          _isFirstCapturedState = true;
        },
        child: widget.child,
      );
}
