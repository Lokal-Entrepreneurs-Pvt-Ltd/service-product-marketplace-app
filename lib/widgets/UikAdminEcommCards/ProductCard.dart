
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UikButton/UikButton.dart';
// import '../UikButton/UikButton.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatefulWidget {
  final productName;
  final productDesc;
  final productImage;
  final buttonText;
  final productSize;
  final productId;
  final productPrice;
  final ratingVal;
  final ratingDesc;

  const ProductCard(
      {Key? key,
      this.productName = 'Nike Air Max 270',
      this.productDesc = 'Rave BD',
      this.productImage = "/images/blue.png",
      this.buttonText = 'Shoe',
      this.productSize = 48,
      this.productId = 'UY2345',
      this.productPrice = '650',
      this.ratingVal = 5,
      this.ratingDesc = '5(14)'})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isChecked = false;

  _ProductCardState();

  @override
  Widget build(BuildContext context) {
    // String productName;
    return Container(
        width: 1121,
        height: 85,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffBABFC5), width: 1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CHECK-BOX CONTAINER
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(21, 32, 15, 33),
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

              //PRODUCT IMAGE CONTAINER
              Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xffF5F5F5),
                    // color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Image.asset(widget.productImage)),

              //PRODUCT DESCRIPTION CONTAINER
              Container(
                // color: Colors.blue,
                margin: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.productDesc,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff82868C),
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //button container
              Container(
                // color: Colors.amber,
                // padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                margin: const EdgeInsets.only(left: 160, top: 31),
                child: UikButton(
                  textColor: const Color(0xff9E9E9E),
                  backgroundColor: const Color(0xffF5F5F5),
                  borderColor: const Color(0xffF5F5F5),
                  text: widget.buttonText,
                  widthSize: 66,
                  heightSize: 24,
                ),
              ),

              //size container
              Container(
                margin: const EdgeInsets.only(left: 73),
                width: 16,
                height: 16,
                child: Text(
                  widget.productSize.toString(),
                  style: GoogleFonts.poppins(
                      color: const Color(0xff9E9E9E),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),

              //id container
              Container(
                margin: const EdgeInsets.only(left: 72),
                width: 45,
                height: 16,
                child: Text(
                  widget.productId,
                  style: GoogleFonts.poppins(
                      color: const Color(0xff9E9E9E),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),

              //PRICE CONTAINER
              Container(
                margin: const EdgeInsets.only(left: 65),
                width: 31,
                height: 16,
                child: Text(
                  '\$' + widget.productPrice,
                  style: GoogleFonts.poppins(
                      color: const Color(0xff9E9E9E),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),

              // rating container
              Container(
                margin: const EdgeInsets.only(left: 63),
                // width: 96,
                // color: Colors.blue,
                height: 18,
                child: Row(children: <Widget>[
                  RatingBar.builder(
                    initialRating: widget.ratingVal,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                constraints: const BoxConstraints(
                    maxWidth: double.infinity, minWidth: 0.0),
                height: 16,
                child: Text(
                  widget.ratingDesc,
                  style: GoogleFonts.poppins(
                      color: const Color(0xff9E9E9E),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 62),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xffbdbdbd), width: 1.0),
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
                    )),
              ),
            ],
          ),
        ));
  }
}
