import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lokal/screens/landing_screen/my_agents_list.dart';
import 'package:lokal/screens/landing_screen/my_customers_list.dart';
import 'package:lokal/screens/landing_screen/sl_details_page.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import '../../Widgets/UikCustomTabBar/customTabBar.dart';
import '../../constants/json_constants.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';

class ServiceLandingScreen extends StatefulWidget {
  const ServiceLandingScreen({Key? key});

  @override
  State<ServiceLandingScreen> createState() => _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends State<ServiceLandingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  late Future<ApiResponse> _serviceTabsFuture;
  late dynamic args;

  @override
  void didChangeDependencies() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController = TabController(length: 3, vsync: this);
    args = ModalRoute.of(context)?.settings.arguments;
    _serviceTabsFuture = ApiRepository.getServiceTabsScreen(args);
    // Add a listener to the TabController to update the selected tab when scrolled
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    super.didChangeDependencies();
  }
  @override
  void initState() {

    super.initState();
  }


  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _serviceTabsFuture, // Use the stored future
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }
        dynamic data = snap.data?.data;

        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          appBar: _buildAppBar(data),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SlDetailsPage(),
                      SlMyCustomersList(),
                      Sl_MyAgentsList(),
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

  AppBar _buildAppBar(dynamic data) {
    return AppBar(
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

      ],
      iconTheme: IconThemeData(color: Colors.black), // Change the back button color here
      bottom: TabBar(
        onTap: (ind) {
          setState(() {
            _currentIndex = ind;
          });
        },
        controller: _tabController,
        indicatorColor: const Color(0xFF3F51B5),
        indicatorWeight: 2.5,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        tabs: List.generate(
          (data["tabs"] as List).length,
              (index) {
            dynamic tab = data["tabs"][index];
            return TabElement(text: tab["text"], index: index, isSelected: index == _currentIndex,);
          },
        ),
      ),
    );
  }
}