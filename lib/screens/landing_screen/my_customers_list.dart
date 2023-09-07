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
  List<Map<String, dynamic>> _customerListDataStore = []; // Store customer data
  List<dynamic> _customerWidgets = [];
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = AutoScrollController();
    _fetchCustomerData(); // Call the API to fetch customer data
    super.initState();
  }

  // Function to fetch customer data from the API
  Future<void> _fetchCustomerData() async {

    final response = await ApiRepository.getAllCustomerForUserService({ "serviceId": "16"});
    if (response.isSuccess!) {

      // Extract customer data from the API response
      _customerWidgets = response.data['widgets'] as List<dynamic>;
      // final customers = customerWidgets
      //     .where((widget) => widget['uiType'] == 'UikListItemCustomer')
      //     .toList();

      final dataStore = response.data['dataStore'] as Map<String, dynamic>;
      final customerDataList = _customerWidgets.map((customer) {
        final id = customer['id'] as String;
        return dataStore[id] as Map<String, dynamic>;
      }).toList();

      setState(() {
        _customerListDataStore = customerDataList;
      });
    } else {
      throw Exception('Failed to load customer data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _customerListDataStore.length, // Use the length of customer data
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
            );}
         else if (uiType == 'UikContainerText') {
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
           // Handle other uiTypes as needed
           return SizedBox(); // Placeholder for other uiTypes
         }
          },
        ),
      ),
      persistentFooterButtons: [
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
  }}

class ArrowDetailsWidget extends StatelessWidget {
  final String point;
  const ArrowDetailsWidget(
      {super.key, required this.point, this.fontSize = 12});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.chevron_right,
            size: fontSize,
          ),
          Expanded(
            child: Text(
              point,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarDetailsElement extends StatelessWidget {
  final String text;
  final int index;
  bool isSelected;
  TabBarDetailsElement({
    super.key,
    required this.text,
    required this.index,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
