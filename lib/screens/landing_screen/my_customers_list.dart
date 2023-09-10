import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/landing_screen/customer_details.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

enum WidgetType {
  UikListItemType1,
  UikContainerText,
}

class SlMyCustomersList extends StatefulWidget {
  const SlMyCustomersList({Key? key}) : super(key: key);

  @override
  State<SlMyCustomersList> createState() => _SlDetailsPageState();
}

class _SlDetailsPageState extends State<SlMyCustomersList>
    with TickerProviderStateMixin {
  late final AutoScrollController _scrollController;
  List<Map<String, dynamic>> _customerListDataStore = [];
  List<dynamic> _customerWidgets = [];
  bool _isLoading = true;
  bool _showAddCustomerButton = false;
  late dynamic args;

  @override
  void initState() {
    _scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments;
    _fetchCustomerData();
    // Trigger a redraw
    setState(() {});
  }

  Future<void> _fetchCustomerData() async {
    try {
      final response =
      await ApiRepository.getAllCustomerForUserService(args);
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
      _customerWidgets = customerWidgets;
      _isLoading = false;
      _showAddCustomerButton = true;
    });
  }

  void _handleApiError() {
    setState(() {
      _isLoading = false;
      _showAddCustomerButton = true; // Show the "Add Customer" button
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
    if (!_isLoading && _customerListDataStore.isEmpty) {
      return _buildRetryView(); // Display the retry view
    }
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

  Widget _buildRetryView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "No Customer Added Yet. Kindly Add a Customer! ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center, // Center-align the text
        ),
        SizedBox(height: 20), // Add some vertical spacing
        ElevatedButton(
          onPressed: () {
            // Call the retry method here
            setState(() {
              _isLoading= true;
              _fetchCustomerData();
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.yellow, // Set button background color to yellow
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
            child: Text(
              "Retry",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set text color to black
              ),
            ),
          ),
        ),
      ],
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

    String customerName = customer['name']['text'] ?? '';
    String firstCharacter = customerName.isNotEmpty ? customerName[0].toUpperCase() : ''; // Get the first character

    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => Sl_CustomerDetails(),
        //   ),
        // );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.yellow,
          child: Text(firstCharacter),
        ),
        title: Text(
          customerName,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          customer['phone']['text'] ?? '',
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        trailing: Text(
          customer['date']['text'] ?? '',
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
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
          NavigationUtils.openScreenUntil(ScreenRoutes.addUserServiceCustomer, args);
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
