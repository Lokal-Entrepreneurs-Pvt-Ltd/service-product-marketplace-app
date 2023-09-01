import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../UikButton/UikButton.dart';
import '../../UikTextArea/UikTextArea.dart';

class FirstCard extends StatelessWidget {
  final String? storeName;
  final String? category;
  final String? stockVal;
  final String? skuVal;
  final List<String>? imageURLs;

  const FirstCard({
    super.key,
    this.storeName,
    this.category,
    this.stockVal,
    this.skuVal,
    this.imageURLs,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Container(
        // height: 762,
        child: Column(
          children: [
            // second container ( product name and store name)
            Container(
              margin: const EdgeInsets.only(top: 4, left: 30),
              child: Row(
                children: [
                  // product name-------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 101,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 8.5),
                          child: Text(
                            'Product name',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 39,
                          padding:
                              const EdgeInsets.only(left: 15, top: 11, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Enter product name',
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintStyle: GoogleFonts.poppins(
                                    color: const Color(0xff9e9e9e),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // store name---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 101,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 8.5),
                          child: Text(
                            'Store name',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 39,
                          padding:
                              const EdgeInsets.only(left: 15, top: 10, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter store name',
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintStyle: GoogleFonts.poppins(
                                  color: const Color(0xff9e9e9e),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //third container - description------------
            Container(
              margin: const EdgeInsets.only(top: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for description
                  Container(
                    width: 80,
                    height: 21,
                    margin: const EdgeInsets.only(bottom: 6.3),
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),

                  //for text area
                  const SizedBox(
                    width: 623,
                    child: TextArea(
                      background: true,
                      widthVal: 623,
                      heightVal: 171,
                      bgcolor: Color(0xffEEEEEE),
                      border: false,
                      label: false,
                      corner: 'rectangle',
                      hinttext: 'Enter product name',
                    ),
                  ),
                ],
              ),
            ),

            // 4th container - category and store name
            Container(
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Row(
                children: [
                  // category-------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 67,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 8.5),
                          child: Text(
                            'Category',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 39,
                          padding:
                              const EdgeInsets.only(left: 15, top: 11, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          // child: const MySelect(
                          //   ContainerBackgroundColor: Color(0xffeeeeee),
                          //   ContainerHeight: 306,
                          //   ContainerRadius: 8,
                          //   Heading: true,
                          //   noIcon: false,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  // store name---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 101,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 8.5),
                          child: Text(
                            'Store name',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                            width: 306,
                            height: 39,
                            padding:
                                const EdgeInsets.only(left: 6, top: 5.5, bottom: 4.5),
                            decoration: const BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: [
                                if (storeName != null) ...[
                                  Chip(
                                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                    label: Text(storeName!),
                                    labelStyle: GoogleFonts.poppins(
                                        color: const Color(0xffffffff),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    backgroundColor: const Color(0xff9e9e9e),
                                    elevation: 0.0,
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 15,
                                    ),
                                    deleteIconColor: const Color(0xffffffff),
                                    onDeleted: () {},
                                  ),
                                ],
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // 5th container - stock and sku
            Container(
              margin: const EdgeInsets.only(top: 19.5, left: 30),
              child: Row(
                children: [
                  // STOCK-------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 39,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 8.5),
                          child: Text(
                            'Stock',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 39,
                          padding:
                              const EdgeInsets.only(left: 15, top: 11, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText:
                                  (stockVal != null) ? (stockVal) : (null),
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff9E9E9E),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium),
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SKU---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 101,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 8.5),
                          child: Text(
                            'Sku',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 39,
                          padding:
                              const EdgeInsets.only(left: 15, top: 10, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: (skuVal != null) ? (skuVal) : (null),
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff9E9E9E),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium),
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //6th container - PRODUCT IMAGES CONTAINER
            Container(
              margin: const EdgeInsets.only(top: 23.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 105,
                    height: 21,
                    child: Text(
                      'Product Image',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 624,
                    height: 149,
                    child: DottedBorder(
                      color: const Color(0xff212121),
                      strokeWidth: 1,
                      dashPattern: const [10, 6],
                      child: Container(
                        padding: const EdgeInsets.only(left: 11, top: 9, bottom: 9),
                        color: const Color(0xffE0E0E0),
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            if (imageURLs != null) ...[
                              for (var i = 0; i < imageURLs!.length; i++)
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(right: 11),
                                      width: 142,
                                      height: 131,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        child: Image.network(
                                          imageURLs![i],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 8,
                                      left: 110,
                                      bottom: 103,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color(0xffFF6B93),
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.delete_outline_sharp,
                                          color: Color(0xffffffff),
                                          size: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                            Container(
                                width: 142,
                                height: 131,
                                color: const Color(0xffbdbdbd),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Color(0xff9E9E9E),
                                    ),
                                    Container(
                                        child: Column(
                                      children: [
                                        Text(
                                          'Choose a file',
                                          style: GoogleFonts.poppins(
                                              color: const Color(0xff212121),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ),
                                        Text(
                                          'or drag it here',
                                          style: GoogleFonts.poppins(
                                              color: const Color(0xff9E9E9E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        )
                                      ],
                                    )),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 7th container - buttons
            Container(
              width: 624,
              margin: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UikButton(
                      textColor: const Color(0xff9E9E9E),
                      backgroundColor: const Color(0xffffffff),
                      borderColor: const Color(0xffEEEEEE),
                      text: 'Cancel',
                      widthSize: 136,
                      heightSize: 38),
                  const SizedBox(
                    width: 11,
                  ),
                  UikButton(
                      textColor: const Color(0xff212121),
                      backgroundColor: const Color(0xffFEE440),
                      borderColor: const Color(0xffFEE440),
                      text: 'Save',
                      widthSize: 136,
                      heightSize: 38)
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
