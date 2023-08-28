import 'package:flutter/material.dart';
import 'package:lokal/screens/landing_screen/sl_details_page.dart';
import '../../Widgets/UikCustomTabBar/customTabBar.dart';

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
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.90),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          "Samhita",
          style: TextStyle(
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
            debugPrint(ind.toString());
            setState(() {
              _currentIndex = ind;
            });
          },
          controller: _tabController,
          indicatorColor: Color(0xFF3F51B5),
          indicatorWeight: 2.5,
          indicatorPadding:
                  EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          tabs: [
            TabElement(
              text: "Detail",
              index: 0,
              isSelected: _currentIndex == 0,
            ),
            TabElement(
              text: "Customer",
              index: 1,
              isSelected: _currentIndex == 1,
            ),
            TabElement(
              text: "Agent",
              index: 2,
              isSelected: _currentIndex == 2,
            ),
            TabElement(
              text: "Earnings",
              index: 3,
              isSelected: _currentIndex == 3,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Sl_DetailsPage(),
                  Sl_DetailsPage(),
                  Sl_DetailsPage(),
                  Sl_DetailsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
