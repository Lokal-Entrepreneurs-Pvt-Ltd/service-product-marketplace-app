import "package:flutter/material.dart";
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';

import '../UikButton/UikButton.dart';
import '../UikSlidder/slidder.dart';

class CategoryCard extends StatefulWidget {
  final list;
  final sortByList;
  const CategoryCard({super.key, 
    required this.list,
    required this.sortByList,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  var index = -1;
  var sortByIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 267,
          height: 608,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Category ka text Keval
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    child: const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(
                          0xFF212121,
                        ),
                      ),
                    ),
                  ),
                  //Categories...........
                  SizedBox(
                    height: 170,
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.list.length; i++) ...[
                            Container(
                              child: Row(
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          index = i;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 20.6,
                                          top: 13.6,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 8.0,
                                              width: 8.0,
                                              margin: const EdgeInsets.only(
                                                right: 5.06,
                                              ),
                                              decoration: BoxDecoration(
                                                color: (index != i)
                                                    ? const Color(
                                                        0xFF3A3C40,
                                                      )
                                                    : const Color(
                                                        0xFFEF5350,
                                                      ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                widget.list[i]["categoryName"],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: (index != i)
                                                      ? const Color(
                                                          0xFF3A3C40,
                                                        )
                                                      : const Color(
                                                          0xFFEF5350,
                                                        ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),

                                  //not Clickable this is the stock
                                  Container(
                                    width: 32,
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                      right: 15.5,
                                      top: 13.5,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFBDBDBD),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.list[i]["inStock"].toString(),
                                        style: const TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  //SortBy ka text Keval
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    child: const Text(
                      "Sort By",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(
                          0xFF212121,
                        ),
                      ),
                    ),
                  ),
                  //sort by.................
                  SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < widget.sortByList.length;
                              i++) ...[
                            Container(
                              child: Row(
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sortByIndex = i;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 20.6,
                                          top: 13.6,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 8.0,
                                              width: 8.0,
                                              margin: const EdgeInsets.only(
                                                right: 5.06,
                                              ),
                                              decoration: BoxDecoration(
                                                color: (sortByIndex != i)
                                                    ? const Color(
                                                        0xFF3A3C40,
                                                      )
                                                    : const Color(
                                                        0xFFEF5350,
                                                      ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                widget.sortByList[i],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: (sortByIndex != i)
                                                      ? const Color(
                                                          0xFF3A3C40,
                                                        )
                                                      : const Color(
                                                          0xFFEF5350,
                                                        ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  //price Range...........
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                          ),
                          child: const Text(
                            "Price Range",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF212121,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.blueAccent),
                          // ),
                          margin: const EdgeInsets.only(
                            top: 9,
                            left: 10,
                          ),
                          child: const Slidder(
                            isRange: true,
                            isRounded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //button...........
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    child: UikButton(
                      widthSize: 230,
                      text: "View Cart",
                      stuck: true,
                      rightElement: const UikIcon(valIcon: Icons.card_travel),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
