import 'package:fconnectivity/fconnectivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AppWidget());

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
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
                      ColoredBox(
                    color: Colors.yellow,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        text:
                            'This text widget is wrapped with InternetAccessConsumer, so '
                            'it listens to internet access states, and also it '
                            'rebuilds when internet access state changes.'
                            '\nCurrent state of internet access: ',
                        children: [
                          TextSpan(
                            text: hasInternetAccess
                                ? 'Available'
                                : 'Not Available',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                  child: const ColoredBox(
                    color: Colors.cyan,
                    child: Text(
                      'This text widget is wrapped with an InternetAccessListener, '
                      'it listens to internet access states, but it does not '
                      'rebuild when internet access state changes.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
