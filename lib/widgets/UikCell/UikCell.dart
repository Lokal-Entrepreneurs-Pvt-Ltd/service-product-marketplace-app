import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String titleText;
  final Widget? rightChild;
  final Widget? leftChild;
  final subtitleText;
  const Cell({super.key, 
    required this.titleText,
    this.rightChild,
    this.leftChild,
    this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: (subtitleText != null)
            ? const EdgeInsets.only(top: 5)
            : const EdgeInsets.all(0),
        child: (leftChild != null) ? leftChild : const Text(""),
      ),
      title: Text(titleText),
      subtitle: (subtitleText != null) ? Text(subtitleText) : const Text(""),
      trailing: (rightChild != null) ? rightChild : const Text(""),
    );
  }
}
