import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget {
  final title;
  final description;
  final Trigger;
  final backgroundColor;
  final leftElement;
  const SnackBarPage({super.key, 
    required this.title,
    this.description,
    this.leftElement,
    this.Trigger,
    this.backgroundColor = Colors.black,
  });
  SnackBar snackWidget() {
    final snackBar = SnackBar(
      content: SizedBox(
        height: 50,
        child: Row(
          children: [
            SizedBox(
              child: (leftElement != null) ? leftElement : null,
              height: 40,
            ),

            const SizedBox(width: 10),
            SizedBox(
              height: 40,
              child: description != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 20),
                        ),
                        // if (description != null)
                        Text(
                          description,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: const TextStyle(fontSize: 28),
                    ),
            ),
            // SizedBox(width: 120),
            const Spacer(),
            Container(
              child: Trigger,
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: const Duration(milliseconds: 5000),
      // action: SnackBarAction(
      //   label: "Action",
      //   disabledTextColor: Colors.white,
      //   textColor: Colors.yellow,
      //   onPressed: () {
      //     //function
      //   },
      // ),
    );
    return snackBar;
  }

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
