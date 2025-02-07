import 'package:fconnectivity/fconnectivity.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Change the interval of internet access check to 2 seconds.
  InternetAccessChecker.instance.setInternetAccessCheckInterval(
    const Duration(milliseconds: 2000),
  );
  runApp(const AppWidget());
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final TextEditingController _intervalController = TextEditingController();

  @override
  void dispose() {
    _intervalController.dispose();
    super.dispose();
  }

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
                            '\nCurrent state of internet access:\n',
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
                const SizedBox(height: 20),
                TextField(
                  controller: _intervalController,
                  decoration: const InputDecoration(
                    labelText: 'Enter the interval in milliseconds',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    InternetAccessChecker.instance
                        .setInternetAccessCheckInterval(
                      Duration(
                          milliseconds:
                              int.tryParse(_intervalController.text) ?? 0),
                    );
                  },
                  child: const Text('Change internet access check interval'),
                ),
              ],
            ),
          ),
        ),
      );
}
