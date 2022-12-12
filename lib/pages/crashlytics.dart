import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class Crashlytics extends StatelessWidget {
  const Crashlytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            // FirebaseCrashlytics.instance.crash();

            throw Exception();
          },
          child: const Text("Click to throw exception!"),
        ),
      ),
    );
  }
}
