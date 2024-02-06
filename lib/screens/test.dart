import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return DUIPage(
      pageUid: "homepage-65b9f82cea98f4e5239d621b",
      onExternalMethodCalled: (methodId, data) {

        switch (methodId) {
          case 'profileItemPressed':
            debugPrint(data.toString());
        }
      },
    );
  }
}
