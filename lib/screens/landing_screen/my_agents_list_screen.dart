import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utils/network/ApiRepository.dart';

enum WidgetType {
  UikListItemType1,
  UikContainerText,
}
class MyAgentListScreen extends StatefulWidget {
  const MyAgentListScreen({super.key, this.args});
  final dynamic args;

  @override
  State<MyAgentListScreen> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<MyAgentListScreen>
    with TickerProviderStateMixin {
  late final AutoScrollController _scrollController;
  List<Map<String, dynamic>> _agentListDataStore = [];
  List<dynamic> _agentWidgets = [];
  bool _isLoading = true;
  bool _showAddAgentButton = false;

  @override
  void initState() {
    _scrollController = AutoScrollController();
    super.initState();
  }



  @override
  void didChangeDependencies() {

    _fetchAgentData();
    super.didChangeDependencies();
  }

  Future<void> _fetchAgentData() async {
    try {
      final response = await ApiRepository.getAllAgentsForUserService(widget.args);
      if (response.isSuccess!) {
        _updateAgentData(response.data);
      } else {
        _handleApiError();
      }
    } catch (e) {
      _handleApiError();
    }
  }

  void _updateAgentData(Map<String, dynamic> data) {
    final agentWidgets = data['widgets'] as List<dynamic>;
    final dataStore = data['dataStore'] as Map<String, dynamic>;
    final agentDataList = agentWidgets.map((agent) {
      final id = agent['id'] as String;
      return dataStore[id] as Map<String, dynamic>;
    }).toList();

    setState(() {
      _agentListDataStore = agentDataList;
      _agentWidgets= agentWidgets;
      _isLoading = false;
      _showAddAgentButton = true;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Manage Agents", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? _buildLoadingIndicator()
          : _buildAgentList(),
      persistentFooterButtons: _buildFooterButtons(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }



  Widget _buildAgentList() {

    if (!_isLoading && _agentListDataStore.isEmpty) {
      return _buildRetryView(); // Display the retry view
    }
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _agentListDataStore.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        itemBuilder: (ctx, index) {
          final agent = _agentListDataStore[index];
          final uiType = _agentWidgets[index]['uiType'] as String;
          return buildWidgetByType(uiType, agent);
        },
      ),
    );
  }

  Widget _buildRetryView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "No Agents Found. Would you like to retry?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Call the retry method here
            setState(() {
              _isLoading = true;
              _fetchAgentData(); // Replace with your API call method
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Retry",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildWidgetByType(String uiType, Map<String, dynamic> agent) {
    final widgetType = uiTypeMapping[uiType];
    switch (widgetType) {
      case WidgetType.UikListItemType1:
        return _buildAgentListItem(agent);
      case WidgetType.UikContainerText:
        return _buildContainerText(agent);
      default:
        return const SizedBox();
    }
  }


  static const Map<String, WidgetType> uiTypeMapping = {
    'UikListItemType1': WidgetType.UikListItemType1,
    'UikContainerText': WidgetType.UikContainerText,
  };
  Widget _buildAgentListItem(Map<String, dynamic> agent) {

    String agentName = agent['name']['text'] ?? '';
    String firstCharacter = agentName.isNotEmpty ? agentName[0].toUpperCase() : ''; // Get the first character

    return ListTile(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (ctx) => Sl_AgentDetails()));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Text(firstCharacter),
      ),
      title: Text(agentName,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        agent['phone']['text'] ?? '',
        style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey),
      ),
      trailing: Text(
        agent['date']['text'] ?? '',
        style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey),
      ),
    );
  }

  Widget _buildContainerText(Map<String, dynamic> agent) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        agent['text'] ?? '',
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }



  List<Widget> _buildFooterButtons() {
    final footerButtons = <Widget>[];
    footerButtons.add(
      Padding(
        padding: const EdgeInsets.only(top: 0), // Zero top padding
        child: _buildAddAgentButton(),
      ),
    );
    return footerButtons;
  }

  Widget _buildAddAndNotifyButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Split the screen space equally
        children: [
          Container(
            margin: const EdgeInsets.all(8.0), // Add margin around the button
            width: MediaQuery.of(context).size.width / 2.45, // Half of the screen width
            child: InkWell(
              onTap: () {
                NavigationUtils.openScreen(ScreenRoutes.addAgentScreen, widget.args);
              },
              child: UikButton(
                text: "Add Agent",
                textColor: Colors.black,
                textSize: 16.0,
                textWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0), // Add margin around the button
            width: MediaQuery.of(context).size.width / 2.45, // Half of the screen width
            child: InkWell(
              onTap: () {
                NavigationUtils.openScreen(ScreenRoutes.notifyAgentsScreen, widget.args);
              },
              child: UikButton(
                text: "Notify Agent",
                textColor: Colors.black,
                textSize: 16.0,
                textWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildNotifyAgentButton() {
    return Container(
      child: InkWell(
        onTap: () {
          // Add your logic for notifying agents here
        },
        child: UikButton(
          text: "Notify Agent",
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAddAgentButton() {
    return Container(
      child: InkWell(
        onTap: () {
          NavigationUtils.openScreen(ScreenRoutes.addAgentScreen, widget.args);
        },
        child: UikButton(
          text: "Add Agent",
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
