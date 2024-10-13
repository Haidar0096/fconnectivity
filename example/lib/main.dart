import 'package:fconnectivity/fconnectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<InternetAccessCubit>(
          create: (context) => InternetAccessCubit(),
          child: Builder(
            builder: (context) {
              return BlocBuilder<InternetAccessCubit, InternetAccessState>(
                builder: (context, internetAccessState) {
                  final hasInternetAccess = switch (internetAccessState) {
                    HasInternetAccess() => true,
                    HasNoInternetAccess() => false,
                  };
                  return Center(
                    child: Text('Has internet access: $hasInternetAccess'),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
