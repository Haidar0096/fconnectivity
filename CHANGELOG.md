## 0.0.1

* Initial release.

## 0.1.0

* Removed usage of Bloc package to make the package agnostic.
* Added the InternetAccessConsumer, InternetAccessListener classes to listen to internet access state changes.
* Added InternetAccessChecker for configuring the internet access checking process.
* Added a way to dispose resources used, by using theInternetAccessChecker class.

## 0.1.1

* minor refactor of logs and removal of unnecessary logs.

## 0.2.0

* Updated docs and example.
* Added option to set delay before checking for internet access after connectivity state changes.

## 0.3.0

* Added InternetAccessBuilder widget which rebuilds if internet access state changes.
