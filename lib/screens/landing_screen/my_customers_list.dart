import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/landing_screen/customer_details.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:ui_sdk/components/UikContainerText.dart';
import 'package:ui_sdk/components/WidgetType.dart';
import 'package:ui_sdk/props/UikContainerTextProps.dart';

import '../../utils/network/ApiRepository.dart';

class Sl_MyCustomersList extends StatefulWidget {
  const Sl_MyCustomersList({super.key});

  @override
  State<Sl_MyCustomersList> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_MyCustomersList>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AutoScrollController _scrollController;
  int _currentTabNumber = 0;
  List<Map<String, dynamic>> _customerListDataStore = [];
  List<dynamic> _customerWidgets = [];
  bool _isLoading = true;
  bool _showAddCustomerButton = false; // Initialize to false

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = AutoScrollController();
    _fetchCustomerData();
    super.initState();
  }

  Future<void> _fetchCustomerData() async {
    final response = await ApiRepository.getAllCustomerForUserService({"serviceId": "16"});
    if (response.isSuccess!) {
      _customerWidgets = response.data['widgets'] as List<dynamic>;
      final dataStore = response.data['dataStore'] as Map<String, dynamic>;
      final customerDataList = _customerWidgets.map((customer) {
        final id = customer['id'] as String;
        return dataStore[id] as Map<String, dynamic>;
      }).toList();

      setState(() {
        _customerListDataStore = customerDataList;
        _isLoading = false;
        _showAddCustomerButton = true; // Set to true after response is received
      });
    } else {
      setState(() {
        _isLoading = false;
        _showAddCustomerButton = false; // Set to false on error
      });
      // Handle API error here and display an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow), // Set the progress indicator color to yellow
        ),
      )
          : Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _customerListDataStore.length,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: _scrollController,
          itemBuilder: (ctx, index) {
            final customer = _customerListDataStore[index];
            final uiType = _customerWidgets[index]['uiType'] as String;
            if (uiType == 'UikListItemCustomer') {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => Sl_CustomerDetails(),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Text("S"),
                ),
                title: Text(
                  customer['name']['text'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  customer['phone']['text'] ?? '',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                trailing: Text(
                  customer['date']['text'] ?? '',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              );
            } else if (uiType == 'UikContainerText') {
              return Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  customer['text'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      persistentFooterButtons: [
        if (_showAddCustomerButton) // Show the button only when _showAddCustomerButton is true
          Container(
            child: InkWell(
              onTap: () {
                NavigationUtils.openScreen(
                    ScreenRoutes.addUserServiceCustomer);
              },
              child: UikButton(
                text: "Add Customer",
                textColor: Colors.black,
                textSize: 16.0,
                textWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
