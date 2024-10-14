import 'package:fconnectivity/fconnectivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InternetAccessConsumer(
                onInternetAccessGained: (BuildContext context) => debugPrint(
                  'Internet access gained (logged by InternetAccessConsumer)',
                ),
                onInternetAccessLost: (BuildContext context) => debugPrint(
                  'Internet access lost (logged by InternetAccessConsumer)',
                ),
                builder: ({
                  required BuildContext context,
                  required bool hasInternetAccess,
                }) =>
                    Text(
                  'This text widget rebuilds when internet access state changes. Current state of internet access: ${hasInternetAccess ? 'Available' : 'Not Available'}',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              InternetAccessListener(
                onInternetAccessGained: (BuildContext context) => debugPrint(
                  'Internet access gained (logged by InternetAccessListener)',
                ),
                onInternetAccessLost: (BuildContext context) => debugPrint(
                  'Internet access lost (logged by InternetAccessListener)',
                ),
                child: const Text(
                  'This text widget does not rebuild when internet access state changes.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
