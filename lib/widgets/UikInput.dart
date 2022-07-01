import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UikInput extends StatefulWidget {
  const UikInput({Key? key}) : super(key: key);

  @override
  State<UikInput> createState() => _UikInputState();
}

class _UikInputState extends State<UikInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
