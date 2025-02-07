import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';
import 'package:fconnectivity/src/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that listens to the internet access state of the device and
/// invokes the appropriate callback based on the current state.
/// It rebuilds the widget based on the internet access state.
class InternetAccessConsumer extends StatelessWidget {
  /// Creates an [InternetAccessConsumer] instance.
  const InternetAccessConsumer({
    required this.onInternetAccessGained,
    required this.onInternetAccessLost,
    required this.builder,
    super.key,
  });

  /// Callback function to be called when the device gains internet access.
  ///
  /// {@template com.perfektion.fconnectivity.context_callback}
  /// The callback will be called with the current [BuildContext].
  /// {@endtemplate}
  final VoidContextedCallback onInternetAccessGained;

  /// Callback function to be called when the device loses internet access.
  ///
  /// {@macro com.perfektion.fconnectivity.context_callback}
  final VoidContextedCallback onInternetAccessLost;

  /// Builder function that builds the widget based on the internet access
  /// state.
  /// - context: The build context.
  /// - hasInternetAccess: Whether the device has internet access.
  final Widget Function({
    required BuildContext context,
    required bool hasInternetAccess,
  }) builder;

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: InternetAccessCubit.instance,
        child: Builder(
          builder: (context) =>
              BlocConsumer<InternetAccessCubit, InternetAccessState>(
            listener: (context, internetAccessState) =>
                switch (internetAccessState) {
              HasNoInternetAccess() => onInternetAccessLost(context),
              HasInternetAccess() => onInternetAccessGained(context),
            },
            builder: (context, internetAccessState) => builder(
              context: context,
              hasInternetAccess: switch (internetAccessState) {
                HasInternetAccess() => true,
                HasNoInternetAccess() => false,
              },
            ),
          ),
        ),
      );
}
