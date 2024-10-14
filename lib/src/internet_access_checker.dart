import 'package:fconnectivity/src/internet_access_cubit/internet_access_cubit.dart';

/// A singleton class that provides useful methods to configure internet
/// access checking.
///
/// - Methods of this class should be called after `runApp` has been called,
/// or otherwise, `WidgetsFlutterBinding.ensureInitialized()` should be called
/// before calling any method of this class.
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

  /// Sets a new delay for the internet access check after a connectivity
  /// change.
  /// The new delay will affect all the current and future internet
  /// access listeners.
  void setPostConnectivityChangeCheckDelay(Duration duration) =>
      InternetAccessCubit.instance
          .setPostConnectivityChangeCheckDelay(duration);

  /// Disposes the resources used by the service.
  ///
  /// The listeners should not be used after calling this method, neither
  /// should any of the methods of this class.
  Future<void> dispose() async => InternetAccessCubit.instance.close();
}
