import 'package:flutter/material.dart';

import 'InformationPage.dart';
import 'PaymentPage.dart';
import 'SubmissionPage.dart';

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({super.key});

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer>
    with TickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 683,
      height: 750,
      decoration: BoxDecoration(border: Border.all(color: const Color(0xffbabfc5))),
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(0),
        child: ListView(
          shrinkWrap: true,
          children: [
            // top container -  heading and tab-bar
            SizedBox(
              // color: Colors.red,
              height: 68,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 30, right: 107),
                    child: const Text(
                      'Add new customer',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, right: 10),
                    // color: Colors.brown,
                    child: DefaultTabController(
                        length: 3,
                        child: Container(
                          // color: Colors.blue,
                          child: TabBar(
                              controller: tabController,
                              indicatorColor: const Color(0xffEF5350),
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              labelColor: const Color(0xffEF5350),
                              unselectedLabelColor: const Color(0xff212121),
                              tabs: const <Widget>[
                                Tab(
                                  child: Text(
                                    'Information',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    softWrap: false,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Payment',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    softWrap: false,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Submission',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
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
              height: 680,
              child: TabBarView(
                controller: tabController,
                children: [
                  InformationPage(),
                  const PaymentPage(),
                  const SubmissionPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
