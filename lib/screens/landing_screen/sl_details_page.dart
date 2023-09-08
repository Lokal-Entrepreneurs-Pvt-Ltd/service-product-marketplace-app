import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utils/network/ApiRepository.dart';

// todo: naming of this screen in screenroutes
class Sl_DetailsPage extends StatefulWidget {
  const Sl_DetailsPage({super.key});

  @override
  State<Sl_DetailsPage> createState() => _Sl_DetailsPageState();
}

class _Sl_DetailsPageState extends State<Sl_DetailsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AutoScrollController _scrollController;
  int _currentTabNumber = 0;
  List<dynamic> _tabs = [];
  bool _isLoading = true;
  List<dynamic> _templates = [];
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = AutoScrollController();
    _fetchServiceDetails();
    super.initState();
  }


  Future<void> _fetchServiceDetails() async {
    try {
      final response = await ApiRepository.getServiceDetailsById({
        "serviceId": "16",
      });
      if (response.isSuccess!) {
        _updateServiceDetails(response.data);
      } else {
        _handleApiError();
      }
    } catch (e) {
      _handleApiError();
    }
  }

  void _handleApiError() {
    // Handle API errors here
  }

  void _updateServiceDetails(Map<String, dynamic> data) {
    final tabs = data['tabs'] as List<dynamic>;
    final templates = data['templates'] as List<dynamic>;
    setState(() {
      _tabs = tabs;
      _templates= templates;
      _isLoading = false;
    });
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
      if (_isLoading) {
      return _buildLoadingIndicator(); // Or any other loading indicator/widget you prefer
    } else {
      return _buildServiceDetailsList();
    }
  }

  Widget _buildServiceDetailsList(){
    return Container(
      child: Column(
        children: [
          // TabBar
          Container(
            child: _buildTabBar(),
          ),
          const SizedBox(height: 8),
          _buildDetailsListN(_templates),
        ],
      ),
    );
  }

  Widget _buildDetailsListN(List<dynamic> templates) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        children: templates.map<Widget>((template) {
          final String type = template['type'];

          switch (type) {
            case 'IMAGE':
              final String imageUrl = template['imageUrl'];
              return Image.network(imageUrl); // You can use NetworkImage to load the image.
            case 'BULLET_POINTS':
              final String heading = template['heading'];
              final List<Map<String, dynamic>> bulletPoints = (template['bulletPoints'] as List<dynamic>)
                  .cast<Map<String, dynamic>>(); // Explicitly cast the dynamic list to the correct type
              return BulletPointsCard(heading: heading, bulletPoints: bulletPoints);
            case 'VIDEO':
              final String videoUrl = template['videoUrl'];
              // Handle video template
              // You can create a widget for displaying videos here.
              return  Container(
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
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "assets/images/image 72.png",
                        width: double.infinity,
                        height: 175,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),

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
              ); // Placeholder for video, replace with your video widget.
            default:
              return SizedBox(); // Placeholder for unsupported template types.
          }
        }).toList(),
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

  Widget _buildTabBar() {
    return TabBar(
      onTap: (ind) {
        setState(() {
          _currentTabNumber = ind;
        });

        switch (ind) {
          case 0:
            _scrollController!.jumpTo(ind * 100);
            break;
          case 1:
            _scrollController!.jumpTo(ind * 400);
            break;
          default:
            _scrollController!.jumpTo(ind * 320);
            break;
        }
      },
      controller: _tabController,
      isScrollable: true,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF3F51B5),
        ),
      tabs: _tabs.map((tabData) {
        return Tab(
          child: Text(
            tabData['text'],
            style: _getTabItemTextStyle(_tabs.indexOf(tabData)),
          ),
        );
      }).toList(),
    );
  }


  TextStyle _getTabItemTextStyle(int index) {
    bool isSelected = _currentTabNumber == index;
    return GoogleFonts.poppins(
      color: isSelected ? Colors.white : Colors.black,
      fontWeight: FontWeight.w500,
    );
  }
}

class BulletPointsCard extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> bulletPoints;

  BulletPointsCard({required this.heading, required this.bulletPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 21),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: bulletPoints.map((bulletPoint) {
              final text = bulletPoint['text'] as String;
              return ArrowDetailsWidget(
                point: text,
                fontSize: 16,
              );
            }).toList(),
          ),
        ],
      ),
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


