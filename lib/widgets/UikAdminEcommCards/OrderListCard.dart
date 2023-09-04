import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListCard extends StatefulWidget {
  final productId;
  final customerName;
  final date;
  final price;
  final paymentMode;
  final paymentStatus;

  const OrderListCard({
    super.key,
    this.productId = 'UY6574',
    this.customerName = 'Mark ruffalo',
    this.date = '02-21-2019',
    this.price = '750',
    this.paymentMode = 'Paypal',
    this.paymentStatus = 'Paid',
  });

  @override
  State<OrderListCard> createState() => _OrderListCardState();
}

class _OrderListCardState extends State<OrderListCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1121,
      height: 85,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffBABFC5), width: 1.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // CHECK-BOX CONTAINER
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(23, 33, 12, 31),
            child: Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
              side: const BorderSide(
                color: Color(0xff9FA8DA),
                width: 1.0,
              ),
            ),
          ),

          //product id container
          SizedBox(
            width: 53,
            height: 21,
            // margin: EdgeInsets.only(top: 34, bottom: 30),
            child: Text(
              widget.productId,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                color: const Color(0xff212121),
              ),
            ),
          ),

          const Flexible(
            child: SizedBox(width: 168),
          ),

          // name container
          Container(
            height: 21,
            margin: const EdgeInsets.only(right: 92),
            child: Text(
              widget.customerName,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: const Color(0xff9E9E9E)),
            ),
          ),

          //date container
          Container(
            height: 21,
            margin: const EdgeInsets.only(right: 93),
            child: Text(
              widget.date,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: const Color(0xff9E9E9E)),
            ),
          ),

          // price container
          Container(
            height: 21,
            margin: const EdgeInsets.only(right: 93),
            child: Text(
              '\$' + widget.price,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: const Color(0xff9E9E9E)),
            ),
          ),

          // Payment options
          Container(
            height: 21,
            margin: const EdgeInsets.only(right: 108),
            child: Text(
              widget.paymentMode,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: const Color(0xff9E9E9E)),
            ),
          ),

          // payment status
          Container(
            height: 25,
            margin: const EdgeInsets.only(right: 98),
            padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
            decoration: const BoxDecoration(
                color: Color(0xffFEE440),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Text(
              widget.paymentStatus,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: const Color(0xff212121)),
            ),
          ),

          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffbdbdbd), width: 1.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                size: 16.5,
                Icons.edit_outlined,
                color: Color(0xff9e9e9e),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
