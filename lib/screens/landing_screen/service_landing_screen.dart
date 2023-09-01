import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/pages/UikServicesLanding.dart';
import 'package:lokal/screens/landing_screen/my_agents_list.dart';
import 'package:lokal/screens/landing_screen/my_customers_list.dart';
import 'package:lokal/screens/landing_screen/sl_details_page.dart';
import 'package:lokal/screens/landing_screen/sl_earnings_page.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../Widgets/UikCustomTabBar/customTabBar.dart';
import '../../pages/UikServiceDetailsPage.dart';
import '../../utils/network/ApiRepository.dart';

class ServiceLandingScreen extends StatefulWidget {
  const ServiceLandingScreen({super.key});

  @override
  State<ServiceLandingScreen> createState() => _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends State<ServiceLandingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiRepository.getServiceTabsScreen(null),
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }

        // debugPrint(snap.data?.data);
        JsonEncoder encoder = const JsonEncoder.withIndent('  ');
        dynamic data = snap.data?.data;
        // String prettyprint = encoder.convert(data);
        // debugPrint(prettyprint);

        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: Colors.white,
            elevation: 0.5,
            centerTitle: true,
            title: Text(
              "${data["heading"]}",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.black,
                ),
              )
            ],
            bottom: TabBar(
              onTap: (ind) {
                // debugPrint(ind.toString());
                setState(() {
                  _currentIndex = ind;
                });
              },
              controller: _tabController,
              indicatorColor: const Color(0xFF3F51B5),
              indicatorWeight: 2.5,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              tabs: List.generate(
                (data["tabs"] as List).length,
                (index) {
                  dynamic tab = data["tabs"][index];
                  return TabElement(text: tab["text"], index: index);
                },
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      UikServiceDetailsPage(
                              serviceId: "16", serviceCode: "b2b_commerce")
                          .page,
                      Sl_MyCustomersList(),
                      Sl_MyAgentsList(),
                      Sl_Earnings_Page(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
