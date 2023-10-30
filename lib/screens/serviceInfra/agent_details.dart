import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// todo: naming of this screen in screenroutes
class Sl_AgentDetails extends StatefulWidget {
  const Sl_AgentDetails({super.key});

  @override
  State<Sl_AgentDetails> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_AgentDetails>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AutoScrollController _scrollController;
  final int _currentTabNumber = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Agent Details",
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            controller: _scrollController,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.yellow,
                  child: Text("S"),
                ),
                title: Text(
                  "Satendra Pal",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  "+91 123456789",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                trailing: Text(
                  "opted in",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ),
              const SizedBox(height: 15),
              const CustomersDetailsWidget(point: "Full Name", value: "Satendra Pal"),
              const SizedBox(height: 10),
              const CustomersDetailsWidget(point: "Mobile", value: "9876543210"),
              const CustomersDetailsWidget(point: "Email", value: "digia@tech.com"),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          alignment: Alignment.center,
          child: UikButton(
            backgroundColor: Colors.grey.shade200,
            text: "Edit Agent",
            textColor: Colors.black,
            textSize: 16.0,
            textWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  TextStyle _getTabItemTextStyle(int index) {
    bool isSelected = _currentTabNumber == index;
    // debugPrint(_currentTabNumber.toString());
    return GoogleFonts.poppins(
      color: isSelected ? Colors.white : Colors.black,
      fontWeight: FontWeight.w500,
    );
  }
}

class CustomersDetailsWidget extends StatelessWidget {
  final String point;
  final String value;
  const CustomersDetailsWidget(
      {super.key,
      required this.point,
      required this.value,
      this.fontSize = 12});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            point,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
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
