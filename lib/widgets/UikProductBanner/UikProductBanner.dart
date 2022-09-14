import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProductBanner extends StatelessWidget {
  final productImg;
  final productName;
  final imgHeight;

  const MyProductBanner(
      {Key? key, this.productImg, this.productName, this.imgHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxHeight: double.infinity),
      child: Column(
        children: [
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // color: Colors.cyan,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //container for text1
                        Container(
                          // width: 151,
                          // color: Colors.blue,
                          constraints:
                              BoxConstraints(maxHeight: double.infinity),
                          child: Text(
                            productName,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                textStyle:
                                    Theme.of(context).textTheme.headline2,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 28),
                        Container(
                          width: 151,
                          // color: Colors.blue,
                          // constraints: BoxConstraints(maxHeight: double.infinity),
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: 70,
                                child: Text(
                                  'Shop now',
                                  style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffE57373)),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                                // height: 21,
                              ),
                              Container(
                                  width: 11,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    ),
                                    color: Color(0xffE57373),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // constraints: BoxConstraints(maxHeight: double.infinity),
                    // color: Colors.brown,
                    height: imgHeight,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        // color: Colors.brown,
                        image: DecorationImage(
                      image: productImg,
                      fit: BoxFit.contain,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
