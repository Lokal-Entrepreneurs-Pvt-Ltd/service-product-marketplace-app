import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'CardNumberFormatter.dart';

class CardDetailCard extends StatelessWidget {
  const CardDetailCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 653,
          height: 302,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 289,
                        height: 74,
                        margin: const EdgeInsets.only(
                          bottom: 15,
                          left: 31,
                          top: 25,
                        ),
                        // decoration: BoxDecoration(
                        //   // color: backgroundColor,
                        //   borderRadius: BorderRadius.circular(7),
                        //   border: Border.all(color: Colors.black, width: 1.0),
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 96,
                              height: 21,
                              margin: const EdgeInsets.only(
                                bottom: 8.5,
                              ),
                              child: const Text(
                                "Card Number",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF212121),
                                ),
                              ),
                            ),
                            Flexible(
                              //width: 289,
                              //height: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardNumberFormatter(),
                                ],
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: '**** **** **** ****',
                                  counterText: "",
                                ),
                                maxLength: 19,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 289,
                        height: 74,
                        margin: const EdgeInsets.only(
                          bottom: 15,
                          left: 31,
                        ),
                        // decoration: BoxDecoration(
                        //   // color: backgroundColor,
                        //   borderRadius: BorderRadius.circular(7),
                        //   border: Border.all(color: Colors.black, width: 1.0),
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 96,
                              height: 21,
                              margin: const EdgeInsets.only(
                                bottom: 8.5,
                              ),
                              child: const Text(
                                "Expiration",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF212121),
                                ),
                              ),
                            ),
                            Flexible(
                              //width: 289,
                              //height: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardNumberFormatter(),
                                ],
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  // prefixIcon: Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Image.network(
                                  //     'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                                  //     height: 30,
                                  //     width: 30,
                                  //   ),
                                  // ),
                                  border: OutlineInputBorder(),
                                  //hintText: '**** **** **** ****',
                                  counterText: "",
                                ),
                                maxLength: 19,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 289,
                        height: 74,
                        margin: const EdgeInsets.only(
                          bottom: 15,
                          left: 31,
                        ),
                        // decoration: BoxDecoration(
                        //   // color: backgroundColor,
                        //   borderRadius: BorderRadius.circular(7),
                        //   border: Border.all(color: Colors.black, width: 1.0),
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 96,
                              height: 21,
                              margin: const EdgeInsets.only(
                                bottom: 8.5,
                              ),
                              child: const Text(
                                "Secure Code",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF212121),
                                ),
                              ),
                            ),
                            Flexible(
                              //width: 289,
                              //height: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardNumberFormatter(),
                                ],
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  // prefixIcon: Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Image.network(
                                  //     'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                                  //     height: 30,
                                  //     width: 30,
                                  //   ),
                                  // ),
                                  border: OutlineInputBorder(),
                                  // hintText: '**** **** **** ****',
                                  counterText: "",
                                ),
                                maxLength: 19,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Container for the image
                Container(
                  margin: const EdgeInsets.only(
                    left: 65,
                  ),
                  width: 238,
                  height: 226.9,
                  child: Image.asset("assets/images/Illsutration 7.png"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
