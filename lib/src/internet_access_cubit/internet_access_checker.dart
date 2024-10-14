import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';

/// A singleton class that provides useful methods to configure internet
/// access checking.
class InternetAccessChecker {
  InternetAccessChecker._();

  /// The singleton instance of [InternetAccessChecker].
  static final InternetAccessChecker instance = InternetAccessChecker._();

  /// Manually triggers an internet access check and emits the result.
  Future<void> triggerInternetAccessCheck() async =>
      InternetAccessCubit.instance.triggerInternetAccessCheck();

  /// Sets a new interval for periodic internet connection checks.
  void setConnectionCheckInterval(Duration duration) =>
      InternetAccessCubit.instance.setInternetAccessCheckInterval(duration);

  /// Disposes the resources used by the service.
  Future<void> dispose() async => InternetAccessCubit.instance.close();
}
