# fconnectivity

A Flutter package that provides utilities for checking internet connectivity status. It allows developers to easily manage and respond to changes in internet access state within their applications.

# Usage

Somewhere in your code, you should inject the `InternetAccessCubit`:

For example using `BlocProvider`:

```dart
@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => InternetAccessCubit(), 
    child: YourWidget(),
  );
}
```

Then you can use the `InternetAccessCubitListener` widget to listen to the internet access state (make sure the `InternetAccessCubit` is provided somewhere in the widget tree above this widget):

```dart
@override
Widget build(BuildContext context) {
  return const InternetAccessCubitListener(
    onHasInternetAccess: (context, isFirstCapturedState) =>
        print('Connected to the internet'),
    onHasNoInternetAccess: (context, isFirstCapturedState) =>
        print('Disconnected from the internet'),
    child: YourWidget(),
  );
}
```
