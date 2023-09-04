import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';

import '../../UikIcon/uikIcon.dart';

class InformationPage extends StatelessWidget {
  String firstName,
      lastName,
      email,
      location,
      phone,
      city,
      country,
      state,
      status;

  InformationPage({
    Key? key,
    this.firstName = 'shahria',
    this.lastName = 'xyz',
    this.email = 'xyz@gmail.com',
    this.location = 'corner street',
    this.phone = '73645382',
    this.city = 'Sydney',
    this.country = 'Australia',
    this.state = 'wales',
    this.status = 'active',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //avatar image
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Container(
                  child: const UikAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://www.shareicon.net/data/512x512/2016/09/15/829452_user_512x512.png')),
                ),
                Positioned(
                  left: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffE57373),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 30,
                    height: 30,
                    child: const UikIcon(
                      valIcon: Icons.camera_alt_rounded,
                      iconColor: Colors.white,
                      //backgroundColor: Color(0xffE57373),
                      iconSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2nd container
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
            child: Row(
              children: [
                //left container
                Container(
                  margin: const EdgeInsets.only(right: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'First Name',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //right container
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'Last Name',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //3rd container
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 19.5),
            child: Row(
              children: [
                //left container
                Container(
                  margin: const EdgeInsets.only(right: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //right container
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // 4th container
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 19.5),
            child: Row(
              children: [
                //left container
                Container(
                  margin: const EdgeInsets.only(right: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        // padding: EdgeInsets.only(left: 10, bottom: 13),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //right container
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'City',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // 5th container
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 19.5),
            child: Row(
              children: [
                //left container
                Container(
                  margin: const EdgeInsets.only(right: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'Country',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //right container
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //label container
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.5),
                        child: const Text(
                          'State / Region',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      //text-field container
                      Container(
                        width: 306,
                        height: 39,
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9E9E9E)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // 6th container
          Container(
            margin: const EdgeInsets.only(top: 19.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //label container
                Container(
                  margin: const EdgeInsets.only(bottom: 8.5),
                  child: const Text(
                    'Status',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),

                //text-field container
                Container(
                  width: 623,
                  height: 39,
                  padding: const EdgeInsets.only(left: 10, bottom: 13, right: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Stack(children: [
                    TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff9E9E9E)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    Positioned(
                        // left: 600,
                        right: 2,
                        top: 10,
                        // bottom: 2,
                        child: UikIcon(
                          valIcon: Icons.expand_more_outlined,
                          iconSize: 20,
                          iconColor: Color(0XFF9E9E9E),
                        ))
                  ]),
                ),
              ],
            ),
          ),

          //7th container -> button
          Container(
            margin: const EdgeInsets.only(left: 517, top: 27.5, right: 30),
            child: UikButton(
              text: "Next",
              widthSize: 136,
              heightSize: 38,
              type: "primary",
              stuck: true,
              textWeight: FontWeight.w600,
              textSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
