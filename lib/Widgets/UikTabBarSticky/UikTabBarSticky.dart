import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/Widgets/UikButton/UikButton.dart';
import 'package:login/Widgets/UikInput/UikInput.dart';
import 'package:login/Widgets/UikTabBar/tabBar.dart';
import 'package:login/Widgets/UikTabBarSticky/UikBottomNavigationBar.dart';

class UikTabBarSticky extends StatelessWidget {
  const UikTabBarSticky({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
       Container(
        child: 
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    "bag",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212121)),
                  ),
                ),
          
                //BagItems
          
                Container(
                  width: 400,
                  height: 150,
                  // decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.blueAccent)
                  //            ),
                  child: Row(
                    children: [
                      //............................................Image...................................................//
                      Flexible(
                        child: Container(
                          width: 94,
                          height: 115,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500,https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500,https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                              fit: BoxFit.cover,
                            ),
                            // shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      //...............................................ImgPrice.........................................//
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 201,
                            height: 24,
                            child: Text(
                              "\$45",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                          //........................................................ImgDescription..............................//
                          Container(
                            width: 201,
                            height: 32,
                            // color: Colors.black,
                            child: Text(
                              "I'm a Product",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
          
                          // if(_uikBagItemProps.stepper != null) ...[
                          //   _uikBagItemProps.stepper!
                          // ]
                          // Container(
                          //   child: MyStepper(),
                          //   width: 98,
                          //   height: 36,
                          //   margin: EdgeInsets.only(left: 0),
                          //   color: Colors.pink,
                          // ),
          
                          //.....................................................Stepper..............................................//
          
                          // Container(
                          //   // child: MyStepper(),
                          //   // alignment: Alignment.centerLeft,
                          //   width: 201,
                          //   height: 36,
                          //   color: Colors.blue,
                          //   // height: 12,
                          //   // color: Colors.pink,
                          //   child: MyStepper(),
                          // ),
                          // MyStepper(
                          // itemPrice: imgPrice,
                          // fun: ScreenFunction,
                          // ),
                        ],
                      ),
                      //................................................CrossShape..............................................//
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 18,
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            //  decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.blueAccent)
                            //  ),
                            // width: 200,
                            // height: 200,
                            child: Icon(Icons.close_rounded),
                            // decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //     image:NetworkImage(
                            //       "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500,https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500,https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                            //       ),
                            //     fit: BoxFit.fill,
                            //   ),
                            //   shape: BoxShape.circle,
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          
                //promocode
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text(
                    "promocode",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212121)),
                  ),
                ),
          
                //Promocode TextField
                Container(
                  width: 400,
                  height: 100,
                  child: UikInput(
                    rightElement: Icon(Icons.close_rounded),
                  ),
                ),
          
                //Text field Component
                Container(
                  width: 370,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // width: 57,
                              // height: 32,
                              child: const Text(
                                "total",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 250,
                            // ),
                            Container(
                              // width: 98,
                              // height: 32,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                "\$34",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              child: const Text("Promocode",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9E9E9E))),
                            ),
                            //  const SizedBox(
                            //   width: 225,
                            // ),
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              child: Text(
                                "\$-25",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9E9E9E),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
          
                //button
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  child: UikButton(text: "Continue"),
                ),
        
               
              ],
            ),
          ),
       
        
      
    );
  }
}
