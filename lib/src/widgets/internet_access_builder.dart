import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that listens to the internet access state of the device and
/// rebuilds based on the internet access state.
class InternetAccessBuilder extends StatelessWidget {
  /// Creates an [InternetAccessBuilder] instance.
  const InternetAccessBuilder({
    required this.builder,
    super.key,
  });

  /// Builder function that builds the widget based on the internet access
  /// state.
  /// - [context]: The build context.
  /// - [hasInternetAccess]: Whether the device has internet access.
  final Widget Function({
    required BuildContext context,
    required bool hasInternetAccess,
  }) builder;

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: InternetAccessCubit.instance,
        child: Builder(
          builder: (context) =>
              BlocBuilder<InternetAccessCubit, InternetAccessState>(
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
