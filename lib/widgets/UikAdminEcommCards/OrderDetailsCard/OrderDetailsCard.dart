import 'package:flutter/material.dart';
import 'package:login/widgets/UikAdminEcommCards/OrderDetailsCard/OrderPage.dart';
import 'package:login/widgets/UikAdminEcommCards/OrderDetailsCard/ProductPage.dart';

import 'InvoicePage.dart';

class orderDetails extends StatefulWidget {
  @override
  State<orderDetails> createState() => _orderDetailsState();
}

class _orderDetailsState extends State<orderDetails>
    with TickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  int _selectedTabBar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1122,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0XFFBABFC5)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: ListView(
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Card(
              elevation: 10,
              margin: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TAB-BAR CONTAINER
                  Container(
                    height: 85,
                    // margin: EdgeInsets.only(right: 800),
                    // width: 260,
                    child: DefaultTabController(
                      length: 3,
                      child: Container(
                        // width: 320,
                        // color: Colors.black,
                        child: TabBar(
                          onTap: (index) {
                            print(index);
                            setState(() {
                              _selectedTabBar = index;
                            });
                          },
                          controller: tabController,
                          indicatorColor: Color(0xffEF5350),
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 23, top: 15),
                          labelColor: Color(0xffEF5350),
                          unselectedLabelColor: Color(0xff212121),
                          // controller: _tabController,
                          tabs: <Widget>[
                            Tab(
                              child: Container(
                                // color: Colors.amber,
                                // width: 89,
                                child: const Text(
                                  'Order Details',
                                  style: TextStyle(fontSize: 13),
                                  softWrap: false,
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                // color: Colors.amber,
                                // width: 54,
                                child: const Text(
                                  'Product',
                                  style: TextStyle(fontSize: 13),
                                  softWrap: false,
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                // color: Colors.amber,
                                // width: 89,
                                child: const Text(
                                  'Invoice',
                                  style: TextStyle(fontSize: 13),
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xffBDBDBD),
                  ),
                  Container(
                    height: (_selectedTabBar == 0)
                        ? (328)
                        : ((_selectedTabBar == 1) ? (328) : (611)),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    // height: 328,
                    // constraints: const BoxConstraints(maxHeight: double.infinity),
                    // height: 328,

                    child: TabBarView(
                      controller: tabController,
                      children: [OrderPage(), ProductPage(), InvoicePage()],
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
