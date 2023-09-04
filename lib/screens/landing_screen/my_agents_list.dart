import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screens/landing_screen/agent_details.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// todo: naming of this screen in screenroutes
class Sl_MyAgentsList extends StatefulWidget {
  const Sl_MyAgentsList({super.key});

  @override
  State<Sl_MyAgentsList> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_MyAgentsList>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AutoScrollController _scrollController;
  int _currentTabNumber = 0;

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
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 15,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: _scrollController,
          itemBuilder: (ctx, index) {
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
                    fontWeight: FontWeight.w400,
                    color: Colors.green),
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        Container(
          child: UikButton(
            text: "Add Agent",
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
