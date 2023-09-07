import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/landing_screen/customer_details.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utils/network/ApiRepository.dart';


enum WidgetType {
  UikListItemType1,
  UikContainerText,
}

class Sl_MyCustomersList extends StatefulWidget {
  const Sl_MyCustomersList({super.key});

  @override
  State<Sl_MyCustomersList> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_MyCustomersList>
    with TickerProviderStateMixin {
  late final AutoScrollController _scrollController;
  List<Map<String, dynamic>> _customerListDataStore = [];
  List<dynamic> _customerWidgets = [];
  bool _isLoading = true;
  bool _showAddCustomerButton = false;

  @override
  void initState() {
    _scrollController = AutoScrollController();
    _fetchCustomerData();
    super.initState();
  }

  Future<void> _fetchCustomerData() async {
    try {
      final response = await ApiRepository.getAllCustomerForUserService({"serviceId": "16"});
      if (response.isSuccess!) {
        _updateCustomerData(response.data);
      } else {
        _handleApiError();
      }
    } catch (e) {
      _handleApiError();
    }
  }

  void _updateCustomerData(Map<String, dynamic> data) {
    final customerWidgets = data['widgets'] as List<dynamic>;
    final dataStore = data['dataStore'] as Map<String, dynamic>;
    final customerDataList = customerWidgets.map((customer) {
      final id = customer['id'] as String;
      return dataStore[id] as Map<String, dynamic>;
    }).toList();

    setState(() {
      _customerListDataStore = customerDataList;
      _customerWidgets= customerWidgets;
      _isLoading = false;
      _showAddCustomerButton = true;
    });
  }

  void _handleApiError() {
    setState(() {
      _isLoading = false;
      // Handle error, e.g., display an error message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? _buildLoadingIndicator()
          : _buildCustomerList(),
      persistentFooterButtons: _showAddCustomerButton
          ? [_buildAddCustomerButton()]
          : [],
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }

  Widget _buildCustomerList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _customerListDataStore.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        itemBuilder: (ctx, index) {
          final customer = _customerListDataStore[index];
          final uiType = _customerWidgets[index]['uiType'] as String;
          return buildWidgetByType(uiType, customer);
        },
      ),
    );
  }
  Widget buildWidgetByType(String uiType, Map<String, dynamic> customer) {
    final widgetType = uiTypeMapping[uiType];
    switch (widgetType) {
      case WidgetType.UikListItemType1:
        return _buildCustomerListItem(customer);
      case WidgetType.UikContainerText:
        return _buildContainerText(customer);
      default:
        return SizedBox();
    }
  }

  static const Map<String, WidgetType> uiTypeMapping = {
    'UikListItemType1': WidgetType.UikListItemType1,
    'UikContainerText': WidgetType.UikContainerText,
  };

  Widget _buildCustomerListItem(Map<String, dynamic> customer) {
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
  }

  Widget _buildContainerText(Map<String, dynamic> customer) {
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
  }

  Widget _buildAddCustomerButton() {
    return Container(
      child: InkWell(
        onTap: () {
          NavigationUtils.openScreen(ScreenRoutes.addUserServiceCustomer);
        },
        child: UikButton(
          text: "Add Customer",
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
