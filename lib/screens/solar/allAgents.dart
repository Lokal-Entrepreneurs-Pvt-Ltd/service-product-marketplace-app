import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
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

class _Sl_DetailsPageState extends State<AllAgentForService>
    with TickerProviderStateMixin {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            NavigationUtils.pop();
          },
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
    if (_agentList.isEmpty) {
      return _buildRetryView(); // Display the retry view
    }
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTitle("Fill Your Details", 18, FontWeight.w500),
                GestureDetector(
                  onTap: () {
                    NavigationUtils.openScreen(ScreenRoutes.addAgentInService);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
                    decoration: BoxDecoration(
                      color: UikColor.charizard_400.toColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
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
            child: ListView.builder(
              itemCount: _agentList.length,
              itemBuilder: (ctx, index) {
                String agentName = _agentList[index]['name'] ?? '';
                String firstCharacter = agentName.isNotEmpty
                    ? agentName[0].toUpperCase()
                    : ''; // Get the first character
                return ListTile(
                  leading: CircleAvatar(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetryView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              setState(() {
                _isLoading = true;
                _fetchAgentData(); // Retry API call
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
    return Container(
      child: InkWell(
        onTap: () {
          NavigationUtils.pushAndPopUntil(
              ScreenRoutes.accountSettings, ScreenRoutes.accountSettings);
        },
        child: UikButton(
          text: "Proceed",
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
