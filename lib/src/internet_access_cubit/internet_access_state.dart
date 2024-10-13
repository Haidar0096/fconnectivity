part of 'internet_access_cubit.dart';

/// Base class for all internet access states.
sealed class InternetAccessState {
  const InternetAccessState();
}

/// Represents the state of the [InternetAccessCubit] when the device is
/// connected to the internet (i.e. has internet access).
final class HasInternetAccess extends InternetAccessState {
  /// Creates a [HasInternetAccess] instance.
  const HasInternetAccess();
}

/// Represents the state of the [InternetAccessCubit] when the device is
/// disconnected from the internet (i.e. does not have internet access).
final class HasNoInternetAccess extends InternetAccessState {
  /// Creates a [HasNoInternetAccess] instance.
  const HasNoInternetAccess();
}
