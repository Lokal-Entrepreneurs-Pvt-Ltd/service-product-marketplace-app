import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/landing_screen/agent_details.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utils/network/ApiRepository.dart';




enum WidgetType {
  UikListItemType1,
  UikContainerText,
}
class Sl_MyAgentsList extends StatefulWidget {
  const Sl_MyAgentsList({super.key});

  @override
  State<Sl_MyAgentsList> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_MyAgentsList>
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

  late dynamic args;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments;
    _fetchAgentData();
    super.didChangeDependencies();
  }

  Future<void> _fetchAgentData() async {
    try {
      final response = await ApiRepository.getAllAgentsForUserService(args);
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
      body: _isLoading
          ? _buildLoadingIndicator()
          : _buildAgentList(),
      persistentFooterButtons: _showAddAgentButton
          ? [_buildAddAgentButton()]
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



  Widget _buildAgentList() {
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


  Widget buildWidgetByType(String uiType, Map<String, dynamic> agent) {
    final widgetType = uiTypeMapping[uiType];
    switch (widgetType) {
      case WidgetType.UikListItemType1:
        return _buildAgentListItem(agent);
      case WidgetType.UikContainerText:
        return _buildContainerText(agent);
      default:
        return SizedBox();
    }
  }


  static const Map<String, WidgetType> uiTypeMapping = {
    'UikListItemType1': WidgetType.UikListItemType1,
    'UikContainerText': WidgetType.UikContainerText,
  };
  Widget _buildAgentListItem(Map<String, dynamic> agent) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => Sl_AgentDetails()));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Text("S"),
      ),
      title: Text(
        agent['name']['text'] ?? '',
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
      padding: EdgeInsets.all(8.0),
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

  Widget _buildAddAgentButton() {
    return Container(
      child: InkWell(
        onTap: () {
          NavigationUtils.openScreen(ScreenRoutes.addAgentScreen);
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
