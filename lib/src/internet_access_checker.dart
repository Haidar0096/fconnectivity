import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';

/// A singleton class that provides useful methods to configure internet
/// access checking.
class InternetAccessChecker {
  InternetAccessChecker._();

  /// The singleton instance of [InternetAccessChecker].
  static final InternetAccessChecker instance = InternetAccessChecker._();

  /// Manually triggers an internet access check and notifies internet
  /// access listeners.
  Future<void> triggerInternetAccessCheck() async =>
      InternetAccessCubit.instance.triggerInternetAccessCheck();

  /// Sets a new interval for periodic internet access checks.
  /// The new interval will affect all the current and future internet
  /// access listeners.
  void setInternetAccessCheckInterval(Duration duration) =>
      InternetAccessCubit.instance.setInternetAccessCheckInterval(duration);

  /// Disposes the resources used by the service.
  Future<void> dispose() async => InternetAccessCubit.instance.close();
}
