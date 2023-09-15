import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/firstcard.dart';
import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/secondcard.dart';
import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/thirdcard.dart';

class Addnewproduct extends StatefulWidget {
  const Addnewproduct({super.key});

  @override
  State<Addnewproduct> createState() => _AddnewproductState();
}

class _AddnewproductState extends State<Addnewproduct>
    with TickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  int _selectedTabBar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 683,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0XFFBABFC5)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(0),
        child: ListView(
          shrinkWrap: true,
          children: [
            // TAB-BAR CONTAINER
            SizedBox(
              // color: Colors.amber,
              height: 68,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 30, right: 177),
                    child: const Text(
                      'Add new product',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    // height: 37,
                    margin: const EdgeInsets.only(top: 20, bottom: 4, right: 10),
                    // color: Colors.brown,

                    child: DefaultTabController(
                        length: 3,
                        child: Container(
                          // color: Colors.blue,
                          child: TabBar(
                              onTap: (index) {
                                print(index);
                                setState(() {
                                  _selectedTabBar = index;
                                });
                              },
                              controller: tabController,
                              indicatorColor: const Color(0xffEF5350),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorPadding: const EdgeInsets.only(top: 15),
                              isScrollable: true,
                              labelColor: const Color(0xffEF5350),
                              unselectedLabelColor: const Color(0xff212121),
                              tabs: const <Widget>[
                                Tab(
                                  child: Text(
                                    'Information',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    softWrap: false,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    softWrap: false,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Shipping',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    softWrap: false,
                                  ),
                                )
                              ]),
                        )),
                  )
                ],
              ),
            ),

            SizedBox(
              height: (_selectedTabBar == 0)
                  ? (762)
                  : ((_selectedTabBar == 1) ? (258) : (350)),

              //762 258 350
              child: TabBarView(
                controller: tabController,
                children: const [FirstCard(), secondCard(), thirdCard()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
