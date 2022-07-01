import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "./ActionSheet.dart";

class ActionSheetUtil extends StatelessWidget {
  const ActionSheetUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 6", "Item 7"];
    final obj = ActionSheet(itemList: list);

    return Container(
        child: Container(
      height: 70,
      color: Colors.white,
      child: GestureDetector(
          onTap: () {
            obj.showBottomSheet(context);
          },
          child: Text("click me")),
    ));
  }
}
