import 'package:flutter/material.dart';
import 'package:login/Widgets/UikNavbar/UikNavbar.dart';
import 'package:login/Widgets/UikTabBar/tabBar.dart';

class BagScreen extends StatelessWidget {
  final boolean;
  const BagScreen({Key? key, this.boolean = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: boolean == true
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 150,
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          width: 343,
                          height: 42,
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            "bag",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 98,
                    margin: EdgeInsets.only(top: 136, bottom: 27),
                    // color: Colors.green,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('shape.png'),
                        // fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 229,
                    height: 32,
                    // color: Colors.yellow,
                    // color: Colors.green,
                    child: Text(
                      "your bag is empty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 48,
                    // color: Colors.green,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "items remain in your bag for 1 hour, and then they’re moved to your Saved items",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 343,
                    height: 64,
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    color: Color(0xFFFEE440),
                    child: Center(
                      child: Text(
                        "Start shopping",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 400,
                    height: 104,
                    // color: Colors.red,
                    padding: EdgeInsets.all(0),
                    child: MyTabBar(
                      ll: [
                        Icons.shopping_bag_outlined,
                        Icons.favorite_border_outlined,
                        Icons.notifications_none_rounded,
                        Icons.perm_identity_rounded,
                      ],
                    ),
                  ),
                ],
              ),

              // Change
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 158,
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          width: 343,
                          height: 42,
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            "bag",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Image 1

                  //

                  Container(
                    height: 300,
                    width: 375,
                    child: ListView(
                      children: [
                        Container(
                          width: 400,
                          height: 150,
                          // margin: EdgeInsets.only(top: 136, bottom: 27),
                          // color: Colors.green,

                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  width: 94,
                                  height: 115,
                                  margin: EdgeInsets.only(right: 16, left: 16),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('img.png'),
                                      // fit: BoxFit.fill,
                                    ),
                                    // shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 201,
                                    height: 24,
                                    child: Text(
                                      "\$150.00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    width: 201,
                                    height: 32,
                                    child: Text(
                                      "Wooden bedside table featuring a raised design",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('CrossShape.png'),
                                        // fit: BoxFit.fill,
                                      ),
                                      // shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Image 2

                        Container(
                          width: 400,
                          height: 150,
                          // margin: EdgeInsets.only(top: 136, bottom: 27),
                          // color: Colors.green,

                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  width: 94,
                                  height: 115,
                                  margin: EdgeInsets.only(right: 16, left: 16),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('img2.png'),
                                      // fit: BoxFit.fill,
                                    ),
                                    // shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 201,
                                    height: 24,
                                    child: Text(
                                      "\$280.00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    width: 201,
                                    height: 32,
                                    child: Text(
                                      "Square bedside table with legs, a rattan shelf and a...",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('CrossShape.png'),
                                        // fit: BoxFit.fill,
                                      ),
                                      // shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 343,
                    height: 32,
                    child: Text(
                      "promocode",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 24,
                  ),

                  Container(
                    width: 343,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "LOKAL TEST COUNTER",
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('CrossShapeBlack.png'),
                              // fit: BoxFit.fill,
                            ),
                            // shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 32,
                  ),

                  Container(
                    width: 343,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 57,
                          height: 32,
                          child: Text(
                            "total",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 98,
                          height: 32,
                          child: Text(
                            "\$420.00",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 343,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 93,
                          height: 24,
                          child: Text(
                            "promocode",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 62,
                          height: 24,
                          child: Text(
                            "\$20.00",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ListTile(
                  //   leading: Container(
                  //     width: 94,
                  //     height: 115,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage('img.png'),
                  //         // fit: BoxFit.fill,
                  //       ),
                  //       // shape: BoxShape.circle,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   width: 229,
                  //   height: 32,
                  //   // color: Colors.yellow,
                  //   // color: Colors.green,
                  //   child: Text(
                  //     "your bag is empty",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 24,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   width: 343,
                  //   height: 48,
                  //   // color: Colors.green,
                  //   margin: EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     "items remain in your bag for 1 hour, and then they’re moved to your Saved items",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 16,
                  //       color: Color(0xFF9E9E9E),
                  //     ),
                  //   ),
                  // ),
                  // Spacer(),
                  // Container(
                  //   width: 343,
                  //   height: 64,
                  //   margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  //   color: Color(0xFFFEE440),
                  //   child: Center(
                  //     child: Text(
                  //       "Start shopping",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w500, fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                  Spacer(),
                  Container(
                    width: 400,
                    height: 104,
                    // color: Colors.red,
                    padding: EdgeInsets.all(0),
                    child: MyTabBar(
                      ll: [
                        Icons.shopping_bag_outlined,
                        Icons.favorite_border_outlined,
                        Icons.notifications_none_rounded,
                        Icons.perm_identity_rounded,
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
