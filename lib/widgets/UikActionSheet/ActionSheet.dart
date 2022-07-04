import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class ActionSheet extends StatelessWidget {
  final itemList;
  ActionSheet({this.itemList});
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF737373),
            border: Border.all(
              width: 0,
              color: Color(0xFF737373),
            ),
          ),
          child: Container(
            height: (itemList.length == 1)
                ? 250
                : (itemList.length == 2)
                    ? 300
                    : 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                //Title starts

                Container(
                  margin: EdgeInsets.only(
                    top: 40,
                    left: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //Title Ends

                //ListItems starts

                Expanded(
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemList.length; i++) ...[
                        ListTile(
                          leading: Icon(Icons.star_border_outlined),
                          title: Text(itemList[i]),
                          onTap: () {},
                        ),
                      ]
                    ],
                  ),
                ),
                //ListItems Ends

                //cancel button starts

                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 70,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF5F5F5),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFF5F5F5),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //cancel buttons ends
              ],
            ),
          ),
        );
      },
    );
  }

  void show(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,

      title: Container(
        margin: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      //  androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        for (int i = 0; i < itemList.length; i++) ...[
          BottomSheetAction(
            leading: Icon(Icons.star_border_outlined),
            title: Text(itemList[i]),
            onPressed: () {},
          ),
        ],
      ],
      cancelAction: CancelAction(
        title: Container(
          // color: Color(0xFFF5F5F5),
          width: double.infinity,
          height: 70,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFF5F5F5),
            border: Border.all(
              width: 1,
              color: Color(0xFFF5F5F5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
