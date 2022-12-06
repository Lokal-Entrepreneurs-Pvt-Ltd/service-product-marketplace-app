import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../UikAvatar/uikAvatar.dart';
// import '../../UikAvatar/UikAvatar.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';

class OrderPage extends StatelessWidget {
  final orderId;
  final username;
  final location;
  final contact;
  final avatarImage;
  final occupation;
  final paymentMethod, amount, paymentId, paymentDate, paymentStatus;
  final BillingAddressLandmark, BillingAddress, emailId, number, postalCode;

  const OrderPage({
    super.key,
    this.orderId: '#UY3769',
    this.username: 'Mark ruffalo',
    this.location: 'Arizona, USA',
    this.contact: '0098-23456',
    this.avatarImage:
        'https://thumbs.dreamstime.com/b/female-avatar-profile-picture-vector-female-avatar-profile-picture-vector-102690279.jpg',
    this.occupation: 'Product Manager',
    this.paymentMethod: 'Paypal',
    this.paymentDate: '02-12-2021',
    this.paymentId: '00000-XH3453',
    this.amount: '728',
    this.paymentStatus: 'Paid',
    this.BillingAddressLandmark: 'Corner view',
    this.BillingAddress: 'Corner view,Sylhet zindabazar',
    this.emailId: 'xyz@gmail.com',
    this.number: '0100-293042',
    this.postalCode: '30290',
  });

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Container(
        padding: const EdgeInsets.only(left: 30),
        // width: 100,
        // height: 328,
        child: Column(
          children: [
            // 1st ------ order info row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 29),
                  child: Row(
                    children: [
                      const Text(
                        'Order Info ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff212121)),
                      ),
                      Text(
                        orderId,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9E9E9E)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 24, top: 19),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffbdbdbd), width: 1.0),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      size: 16.5,
                      Icons.edit_outlined,
                      color: const Color(0xff9e9e9e),
                    ),
                  ),
                )
              ],
            ),

            Container(
              margin: const EdgeInsets.only(right: 15, top: 19),
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //first column
                  Container(
                    // color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const Text(
                            'Order from',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            username,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            location,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 38),
                          child: Text(
                            '+' + contact,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              // UikAvatar(
                              //   shape: UikAvatarShape.circle,
                              //   child: Image.network(avatarImage),
                              // ),
                              Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 21,
                                          child: Text(
                                            username,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                color: const Color(0xff3A3C40)),
                                          ),
                                        ),
                                        Container(
                                          height: 16,
                                          child: Text(
                                            occupation,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                color: const Color(0xff9E9E9E)),
                                          ),
                                        ),
                                      ])),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // 2nd column
                  Container(
                    // color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const Text(
                            'Payment Method',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            paymentMethod,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Amount: \$' + amount,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Id : ' + paymentId,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Date : ' + paymentDate,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Status : ' + paymentStatus,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // third column
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const Text(
                            'Billing Address',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            BillingAddressLandmark,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            BillingAddress,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            emailId,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Number : +' + number,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Post code : ' + postalCode,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
