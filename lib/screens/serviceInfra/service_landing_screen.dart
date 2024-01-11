import 'package:flutter/material.dart';
import 'package:lokal/screens/serviceInfra//my_agents_list_screen.dart';
import 'package:lokal/screens/serviceInfra/my_agents_list_service_screen.dart';
import 'package:lokal/screens/serviceInfra/my_customers_list.dart';
import 'package:lokal/screens/serviceInfra/sl_details_page.dart';
import 'package:lokal/screens/serviceInfra/status.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../Widgets/UikCustomTabBar/customTabBar.dart';
import '../../utils/network/ApiRepository.dart';

class ServiceLandingScreen extends StatefulWidget {
  const ServiceLandingScreen({super.key, this.args});
  final dynamic args;

  @override
  State<ServiceLandingScreen> createState() => _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends State<ServiceLandingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  late Future<ApiResponse> _serviceTabsFuture;

  @override
  void didChangeDependencies() {
    _tabController = TabController(length: 4, vsync: this);
    _serviceTabsFuture = ApiRepository.getServiceTabsScreen(widget.args);
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
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }

  int i = 0;

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
        if (i == 0) {
          data["tabs"].add({"id": "status", "text": "Status", "route": ""});
          i++;
        }

        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          appBar: _buildAppBar(data),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SlDetailsPage(
                        args: widget.args,
                      ),
                      SlMyCustomersList(
                        args: widget.args,
                      ),
                      MyAgentListServiceScreen(
                        args: widget.args,
                      ),
                      StatusListScreen(args: widget.args),
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
      actions: const [],
      iconTheme: const IconThemeData(
          color: Colors.black), // Change the back button color here
      bottom: TabBar(
        onTap: (ind) {
          setState(() {
            _currentIndex = ind;
          });
        },
        controller: _tabController,
        indicatorColor: const Color(0xFF3F51B5),
        indicatorWeight: 2.5,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        tabs: List.generate(
          (data["tabs"] as List).length,
          (index) {
            dynamic tab = data["tabs"][index];
            return TabElement(
              text: tab["text"],
              index: index,
              isSelected: index == _currentIndex,
            );
          },
        ),
      ),
    );
  }
}
