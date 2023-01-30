import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/network/retrofit/api_routes.dart';

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFEEB70),
        // backgroundColor: Colors.red,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.person_outline_sharp,
                  size: 50,
                ),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Center(
                      child: Text(
                        'your order is placed',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Center(
                      child: Text(
                        'thanks for your order, we hope you\nenjoyed shopping with us',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF9E9E9E),
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 20, top: 692),
                child: InkWell(
                  onTap: () {
                    goToOrderScreen();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: const Color(0xFF212121), width: 2.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Center(
                        child: Text(
                          "Go to my orders",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void goToOrderScreen() {
  var context = NavigationService.navigatorKey.currentContext;

  Navigator.pushNamed(context!, ApiRoutes.orderScreen);
}
