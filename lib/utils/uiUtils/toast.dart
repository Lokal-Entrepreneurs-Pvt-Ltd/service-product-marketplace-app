import 'package:flutter/material.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';

// void main() {
//   runApp(Toast());
// }

class Toast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSnack(context),
          child: const Text('Show toast'),
        ),
      ),
    );
  }

  void _showSnack(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        // content: UikMyAccountScreen.onMyAccountScreenTapAction(uikAction),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
