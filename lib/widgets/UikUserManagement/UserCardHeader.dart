import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';

class UserCardHeader extends StatelessWidget {
  const UserCardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1121,
          height: 101,
          child: Card(
            elevation: 10,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                        child: const Text(
                          "User Cards",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff3A3C40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 0, 0, 16),
                        child: Row(
                          children: [
                            Container(
                              child: const Text("Dashboard",style: TextStyle(fontSize: 14,color: Color(0xff82868C)),),
                            ),
                            const SizedBox(width: 14.33),
                            Container(
                              child: const Text("•",style: TextStyle(fontSize: 22,color: Color(0xff82868C)),),
                            ),
                            const SizedBox(width: 14.33),
                            Container(
                              child: const Text("User",style: TextStyle(fontSize: 14,color: Color(0xff82868C)),),
                            ),
                            const SizedBox(width: 14.33),
                            Container(
                              child: const Text("•",style: TextStyle(fontSize: 22,color: Color(0xff82868C)),),
                            ),
                            const SizedBox(width: 14.33),
                            Container(
                              child: const Text("Cards",style: TextStyle(fontSize: 14,color: Color(0xff82868C)),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 27, 30, 28),
                  child: UikButton(
                    text: "Add new user",
                    widthSize: 124,
                    heightSize: 38,
                    stuck: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
