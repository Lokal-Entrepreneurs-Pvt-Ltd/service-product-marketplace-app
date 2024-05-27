import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';

class AllAgentForService extends StatefulWidget {
  const AllAgentForService({super.key, this.args});
  final dynamic args;

  @override
  State<AllAgentForService> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<AllAgentForService> {
  List<Map<String, dynamic>> _agentList = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _fetchAgentData();
    super.didChangeDependencies();
  }

  Future<void> _fetchAgentData() async {
    try {
      final response = await ApiRepository.getAllAgentByPartnerId(
          {"partnerId": UserDataHandler.getUserId()});
      if (response.isSuccess!) {
        _updateAgentData(response.data); // Update agent data
      } else {
        _handleApiError();
      }
    } catch (e) {
      _handleApiError();
    }
  }

  void _updateAgentData(List<dynamic> data) {
    setState(() {
      _agentList = data
          .map((e) => e as Map<String, dynamic>)
          .toList(); // Populate _agentList
      _isLoading = false;
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
        leading: GestureDetector(
          onTap: () {
            NavigationUtils.pop();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1715678068186-shape.svg",
              height: 16,
              width: 20,
            ),
          ),
        ),
      ),
      body: _isLoading ? _buildLoadingIndicator() : _buildAgentList(),
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

  Widget buildTitle(String text, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAgentList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTitle("Fill Your Details", 18, FontWeight.w500),
              GestureDetector(
                onTap: () {
                  NavigationUtils.openScreen(
                      ScreenRoutes.addAgentInService, {"fromAllAgent": true});
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
                  decoration: BoxDecoration(
                    color: UikColor.charizard_400.toColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        size: 18,
                      ),
                      buildTitle("Add", 14, FontWeight.w400),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: (_agentList.isEmpty)
              ? _buildRetryView()
              : ListView.builder(
                  itemCount: _agentList.length,
                  itemBuilder: (ctx, index) {
                    String agentName = _agentList[index]['name'] ?? '';
                    String firstCharacter = agentName.isNotEmpty
                        ? agentName[0].toUpperCase()
                        : ''; // Get the first character
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          child: Text(
                            firstCharacter,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        agentName,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        _agentList[index]['mobile'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: UikColor.giratina_500.toColor(),
                        ),
                      ),
                      trailing: _buildPopupMenu(index),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildPopupMenu(int index) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Edit') {
          _editAgent(index);
        } else if (value == 'Delete') {
          _deleteAgent(index);
        }
      },
      // color: Colors.transparent,
      elevation: 0,
      padding: const EdgeInsets.all(0),
      constraints: const BoxConstraints(
        maxWidth: 135,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Edit',
            height: 28,
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.maxFinite,
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: UikColor.charizard_400.toColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border.all(color: UikColor.charizard_400.toColor()),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Edit',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Delete',
            padding: EdgeInsets.all(0),
            height: 28,
            child: Container(
              width: double.infinity,
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border(
                  left: BorderSide(color: ("#BABFC5").toColor()),
                  right: BorderSide(color: ("#BABFC5").toColor()),
                  bottom: BorderSide(color: ("#BABFC5").toColor()),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Remove',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: UikColor.magikarp_300.toColor(),
                ),
              ),
            ),
          ),
        ];
      },
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(50),
      // ),
      icon: const Icon(Icons.more_vert, color: Colors.black),
    );
  }

  void _editAgent(int index) {
    Map<String, dynamic> map = {};
    map.addAll({"fromAllAgent": true});
    map.addAll({"agent": _agentList[index]});
    NavigationUtils.openScreen(ScreenRoutes.addAgentInService, map);
  }

  void _deleteAgent(int index) async {
    try {
      final response = await ApiRepository.deleteCustomerById(
          {"id": _agentList[index]["id"].toString()});

      if (response.isSuccess!) {
        setState(() {
          _agentList.removeAt(index);
        });
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error fetching initial data");
    }
  }

  Widget _buildRetryView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Agents Found.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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

  Widget _buildAddAgentButton() {
    return InkWell(
      onTap: () {
        NavigationUtils.pushAndPopUntil(ScreenRoutes.dynamicPage,
            ScreenRoutes.dynamicPage, {"pageType": "SolarProfile"});
      },
      child: UikButton(
        text: "Proceed",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
      ),
    );
  }
}
