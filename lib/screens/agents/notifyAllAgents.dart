import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import '../../Widgets/UikButton/UikButton.dart';
import '../../constants/json_constants.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/network/ApiRepository.dart';

class NotifyAgentsScreen extends StatefulWidget {
  const NotifyAgentsScreen({Key? key});

  @override
  State<NotifyAgentsScreen> createState() => _NotifyAgentsScreenState();
}

class _NotifyAgentsScreenState extends State<NotifyAgentsScreen>
    with TickerProviderStateMixin {
  late Future<ApiResponse> _agentsList;
  late dynamic args;
  late final List<String> _agentsNotifyList;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments;
    _agentsList = ApiRepository.getAgentDetailsByPartnerIdAndServiceId({
      "serviceId": args['serviceId'],
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _agentsNotifyList = [];
    super.initState();
  }

  void _updateNotifyList(String id) {
    int index = _agentsNotifyList.indexWhere((element) => element == id);
    if (index != -1) {
      _agentsNotifyList.removeAt(index);
      return;
    }
    _agentsNotifyList.add(id);
  }

  Future<void> _notifyAllTheAgentsPressed(List<dynamic> agents) async {
    if (_agentsNotifyList.length == agents.length) {
      _agentsNotifyList.clear();
      return;
    }
    for (var agent in agents) {
      int index = _agentsNotifyList
          .indexWhere((element) => element == agent['id'].toString());
      if (index != -1) {
        continue;
      }
      _agentsNotifyList.add(agent['id'].toString());
    }
  }

  Future<void> _notifyTheAgents() async {
    final response = await _sendNotificationToAgents();
    _handleNotificationResponse(response);
  }

  Future<ApiResponse> _sendNotificationToAgents() async {
    return ApiRepository.createOrUpdateForAgents({
      'agentId': _agentsNotifyList,
      'serviceId': args['serviceId'],
    });
  }

  void _handleNotificationResponse(ApiResponse response) {
    try {
      debugPrint(response.data.toString());
      if (response.isSuccess != null && response.isSuccess == true) {
        _showSuccessSnackBar();
        NavigationUtils.openScreenUntil(
            ScreenRoutes.userServiceTabsScreen, args);
      } else {
        _showErrorSnackBar();
      }
    } catch (e) {
      debugPrint(e.toString());
      _showErrorSnackBar();
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Center(
          child: Text(
            "Agents notified",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Center(
          child: Text(
            "Something went wrong",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodyContainer(),
      persistentFooterButtons: [
        _buildNotifyButton(),
      ],
    );
  }

  Widget _buildBodyContainer() {
    return FutureBuilder(
      future: _agentsList,
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }
        dynamic data = snap.data?.data;
        List<dynamic> agentsList = data;
        return _buildBody(agentsList);
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        "Notify Agents",
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody(List agentsList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          _buildNotifyAllAgentsTile(agentsList),
          Expanded(
            child: _buildAgentsListView(agentsList),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifyAllAgentsTile(List<dynamic> agentsList) {
    return ListTile(
      onTap: () {
        _notifyAllTheAgentsPressed(agentsList);
        setState(() {
          _agentsNotifyList;
        });
      },
      leading: agentsList.length == _agentsNotifyList.length
          ? Icon(
              Icons.check_box,
              size: 24,
              color: Colors.red,
            )
          : Icon(
              Icons.check_box_outline_blank_rounded,
              size: 24,
            ),
      title: Text(
        "Notify All Agents",
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAgentsListView(List<dynamic> agentsList) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 0),
      itemCount: agentsList.length,
      itemBuilder: (ctx, index) {
        var agent = agentsList[index]['agentDetails'];
        bool isSelectedForNotify = _agentsNotifyList.indexWhere(
                    (element) => element == agent['id'].toString()) ==
                -1
            ? false
            : true;
        return ListTile(
          onTap: () {
            _updateNotifyList(agent["id"].toString());
            setState(() {
              _agentsNotifyList;
            });
          },
          leading: isSelectedForNotify
              ? Icon(
                  Icons.check_box,
                  size: 24,
                )
              : Icon(
                  Icons.check_box_outline_blank_rounded,
                  size: 24,
                ),
          title: Text(
            "${agent["firstName"]} ${agent["lastName"]}",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            agent['phoneNumber'].toString() ?? '',
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          trailing: Text(
            agent['isOpted'] == false ? "not opted" : "opted",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: agent['isSubscribed'] == 0 ? Colors.grey : Colors.green,
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotifyButton() {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          if (_agentsNotifyList.isEmpty) {
            return;
          }
          _notifyTheAgents();
        },
        child: UikButton(
          text: " Notify ",
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }
}
