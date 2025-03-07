# fconnectivity

A Flutter package that provides utilities for checking internet connectivity status. It allows developers to easily manage and respond to changes in internet access state within their applications.

## Usage

### Listening to internet access state changes

You can use either the `InternetAccessConsumer` widget or the `InternetAccessListener` class to listen to internet access state changes.

For example:

```dart
// This widget will rebuild whenever the internet access state changes, it will also trigger the onInternetAccessGained and onInternetAccessLost callbacks.
@override
Widget build(BuildContext context) {
  return InternetAccessConsumer(
    onInternetAccessGained: (context) => print('Internet access gained'),
    onInternetAccessLost: (context) => print('Internet access lost'),
    // this builder will be called when the internet access state changes
    builder: (context, hasInternetAccess) => Text(
      'Internet access state: ${hasInternetAccess ? 'Available' : 'Not Available'}',
    ),
  );
}
```

or

```dart
// This widget will not rebuild if the internet access state changes, it will only trigger the onInternetAccessGained and onInternetAccessLost callbacks.
@override
Widget build(BuildContext context) {
  return InternetAccessListener(
    onInternetAccessGained: (context) => print('Internet access gained'),
    onInternetAccessLost: (context) => print('Internet access lost'),
    // this widget will not rebuild if the internet access state changes
    child: YourWidget(),
  );
}
```

or

```dart
// This widget will rebuild whenever the internet access state changes.
@override
Widget build(BuildContext context) {
  return InternetAccessBuilder(
    // this builder will be called when the internet access state changes
    builder: (context, hasInternetAccess) => Text(
      'Internet access state: ${hasInternetAccess ? 'Available' : 'Not Available'}',
    ),
  );
}
```

### Configuring the internet access checking process

You can configure the internet access checking process by using the `InternetAccessChecker` class.

For example:

```dart
// Manually trigger an internet access check and notify listeners about the result.
InternetAccessChecker.instance.triggerInternetAccessCheck();

// Set a new interval for periodic internet access checks.
InternetAccessChecker.instance.setInternetAccessCheckInterval(Duration(seconds: 10));

// Set the delay for the internet access check after a connectivity change occurs.
InternetAccessChecker.instance.setPostConnectivityChangeCheckDelay(Duration(seconds: 1));
```

### Disposing resources

If you don't want to use the internet access checking anymore, dispose the resources this way:

```dart
// Dispose the resources used by the service.
InternetAccessChecker.instance.dispose();
```

- You cannot use the package after calling `InternetAccessChecker.instance.dispose();`

### Notes

- No resources will be used by the package until you start listening to internet access state changes by using one of the listener widgets (`InternetAccessConsumer` or `InternetAccessListener`).

## Support Me

If you like my work and would like to support me, consider buying me a coffee:

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/haidarmehsen)
