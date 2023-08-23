import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sl_DetailsPage extends StatefulWidget {
  Sl_DetailsPage({super.key});

  @override
  State<Sl_DetailsPage> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_DetailsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  int _currentTabNumber = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController();
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
    return Container(
      child: Column(
        children: [
          // TabBar
          Container(
            child: TabBar(
              onTap: (ind) {
                setState(() {
                  _currentTabNumber = ind;
                });

                _scrollController.offset;
                switch (ind) {
                  case 0:
                    _scrollController.jumpTo(ind * 100);
                    break;
                  case 1:
                    _scrollController.jumpTo(ind * 400);
                    break;
                  case 2:
                    _scrollController.jumpTo(ind * 320);
                    break;
                  case 3:
                    _scrollController.jumpTo(ind * 320);
                    break;
                  case 4:
                    _scrollController.jumpTo(ind * 320);
                    break;
                }
              },
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF3F51B5),
              ),

              // indicatorPadding:
              //     EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

              tabs: [
                Tab(
                  child: Text(
                    "Benefits",
                    style: _getTabItemTextStyle(0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Whom To Sell",
                    style: _getTabItemTextStyle(1),
                  ),
                ),
                Tab(
                  child: Text(
                    "Training Video",
                    style: _getTabItemTextStyle(2),
                  ),
                ),
                Tab(
                  child: Text(
                    "How it Workds",
                    style: _getTabItemTextStyle(3),
                  ),
                ),
                Tab(
                  child: Text(
                    "T & C",
                    style: _getTabItemTextStyle(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _scrollController,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Now you as a wholesaler list your products",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            ArrowDetailsWidget(
                                point: "Earn ₹2300 per registration"),
                            ArrowDetailsWidget(point: "8000+ buyers "),
                            ArrowDetailsWidget(point: "12000+ sellers"),
                            ArrowDetailsWidget(point: "Build your Network"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Image.asset("assets/images/image 72.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Benefits",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ArrowDetailsWidget(
                          point: "Earn ₹2300 per registration", fontSize: 16),
                      ArrowDetailsWidget(
                          point: "Track your profit within 7 days ",
                          fontSize: 16),
                      ArrowDetailsWidget(
                          point:
                              "You will receive money to your PayTM / Bank Account within 7 days",
                          fontSize: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Whom To Sell?",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ArrowDetailsWidget(
                          point: "Customers Over the age group of 21 Years",
                          fontSize: 16),
                      ArrowDetailsWidget(
                          point: "Customers with a valid PAN & Aadhaar card",
                          fontSize: 16),
                      ArrowDetailsWidget(
                          point:
                              "Customers Aadhaar card should be linked to mobile number",
                          fontSize: 16),
                    ],
                  ),
                ),
                // Training Video
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Training Video",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "assets/images/image 72.png",
                          width: double.infinity,
                          height: 175,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/image 1.png",
                              height: 36,
                              width: 36,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "How to use Samhita as an agent",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lokal Company",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "7.1 Lakh views",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "4 months ago",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How it Works?",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ArrowDetailsWidget(
                          point: "You must watch all the training videos",
                          fontSize: 16),
                      ArrowDetailsWidget(
                          point:
                              "You shall then share the product link with everyone in your network(Friends/Family)",
                          fontSize: 16),
                      ArrowDetailsWidget(
                          point:
                              "Your customer shall click on the link shared by you to get redirected to the Samhita website",
                          fontSize: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terms & Conditions",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ArrowDetailsWidget(
                          point: "Available only for new users", fontSize: 16),
                      ArrowDetailsWidget(
                          point:
                              "Your customer will have to open the Zyapaar web page using the lokal link (Available on Lokal App)",
                          fontSize: 16),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
