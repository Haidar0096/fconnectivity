import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';
import 'package:fconnectivity/src/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that listens to the internet access state of the device and
/// invokes the appropriate callback based on the current state.
class InternetAccessListener extends StatelessWidget {
  /// Creates an [InternetAccessListener] instance.
  const InternetAccessListener({
    required this.onInternetAccessGained,
    required this.onInternetAccessLost,
    required this.child,
    super.key,
  });

  /// The child widget to wrap with the listener.
  final Widget child;

  /// Callback function to be called when the device gains internet access.
  /// {@template com.perfektion.fconnectivity.does_not_rebuild}
  /// This callback does not rebuild the widget if the internet access state
  /// changes.
  /// {@endtemplate}
  final VoidContextedCallback onInternetAccessGained;

  /// Callback function to be called when the device loses internet access.
  /// {@macro com.perfektion.fconnectivity.does_not_rebuild}
  final VoidContextedCallback onInternetAccessLost;

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: InternetAccessCubit.instance,
        child: Builder(
          builder: (context) =>
              BlocListener<InternetAccessCubit, InternetAccessState>(
            listener: (context, internetAccessState) {
              switch (internetAccessState) {
                case HasNoInternetAccess():
                  onInternetAccessLost(context);
                case HasInternetAccess():
                  onInternetAccessGained(context);
              }
            },
            child: child,
          ),
        ),
      );
}
