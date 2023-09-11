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
import 'package:google_fonts/google_fonts.dart';

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
    _agentsList = ApiRepository.getAllUserAgentByPartnerId({
      "id": 7,
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
    // debugPrint(_agentsNotifyList.toString());
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
    await ApiRepository.createOrUpdateForAgents({
      'agentId': _agentsNotifyList,
      'serviceId': "14",
    }).then((value) {
      try {
        debugPrint(value.data.toString());
        if (value.isSuccess != null && value.isSuccess == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.green,
                content: Center(
                    child: Text(
                  "All agents notified",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ))),
          );
        } else {}
      } catch (e) {
        debugPrint(e.toString());
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
              ))),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _agentsList, // Use the stored future
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }
        dynamic data = snap.data?.data;
        // debugPrint(data.toString());
        List<dynamic> agentsList = data;
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                ListTile(
                  // contentPadding: EdgeInsets.symmetric(vertical: 0),
                  onTap: () {
                    _notifyAllTheAgentsPressed(agentsList);
                    setState(() {
                      _agentsNotifyList;
                    });
                    // debugPrint(_agentsNotifyList.toString());
                  },
                  leading: agentsList.length == _agentsNotifyList.length
                      ? const Icon(
                          Icons.check_box,
                          size: 24,
                          color: Colors.red,
                        )
                      : const Icon(
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
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    itemCount: agentsList.length,
                    itemBuilder: (ctx, index) {
                      var agent = agentsList[index];
                      bool isSelectedForNotify = _agentsNotifyList.indexWhere(
                                  (element) =>
                                      element == agent['id'].toString()) ==
                              -1
                          ? false
                          : true;
                      // debugPrint(
                      //     "id: ${agent['id']}, selected: ${isSelectedForNotify}");
                      return ListTile(
                        onTap: () {
                          _updateNotifyList(agent["id"].toString());
                          setState(() {
                            _agentsNotifyList;
                          });
                          // debugPrint(_agentsNotifyList.toString());
                        },
                        leading: isSelectedForNotify
                            ? const Icon(
                                Icons.check_box,
                                size: 24,
                              )
                            : const Icon(
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        trailing: Text(
                          agent['isSubscribed'] == 0 ? "not opted" : "opted",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: agent['isSubscribed'] == 0
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: [
            Container(
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
            )
          ],
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }
}
