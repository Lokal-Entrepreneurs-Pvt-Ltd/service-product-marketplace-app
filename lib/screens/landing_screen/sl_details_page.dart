import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:ui_sdk/components/UikVideoPlayerNew.dart';
import 'package:ui_sdk/components/WidgetType.dart';
import 'package:ui_sdk/props/UikVideoPlayerNewProps.dart';

import '../../Widgets/UikButton/UikButton.dart';
import '../../utils/network/ApiRepository.dart';

enum TemplateType {
  Image,
  BulletPoints,
  Video,
  Unknown,
}

class Args {
  static const String typeImage = 'IMAGE';
  static const String typeBulletPoints = 'BULLET_POINTS';
  static const String typeVideo = 'VIDEO';

  // Add other constants for keys used in the template data here
  static const String headingKey = 'heading';
  static const String bulletPointsKey = 'bulletPoints';
  static const String videoUrlKey = 'videoUrl';
}

class SlDetailsPage extends StatefulWidget {
  const SlDetailsPage({super.key});

  @override
  State<SlDetailsPage> createState() => _SlDetailsPageState();
}

class _SlDetailsPageState extends State<SlDetailsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AutoScrollController _scrollController;
  int _currentTabNumber = 0;
  List<dynamic> _tabs = [];
  bool _isLoading = true;
  List<dynamic> _templates = [];
  bool _isOptedIn = false;
  late dynamic args;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments;
    _fetchServiceDetails();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = AutoScrollController();

    super.initState();
  }

  Future<void> _fetchServiceDetails() async {
    try {
      final response = await ApiRepository.getServiceDetailsById(args);
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
    final isOptedIn = data['isOptedIn'] as bool;
    setState(() {
      _tabs = tabs;
      _templates = templates;
      _isLoading = false;
      _isOptedIn = isOptedIn;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _buildLoadingIndicator() : _buildServiceDetailsList(),
      persistentFooterButtons: _isLoading
          ? []
          : _isOptedIn
              ? [_buildAlreadyOptedButton()]
              : [_buildOptInButton()],
    );
  }

  Widget _buildAlreadyOptedButton() {
    return UikButton(
      text: "Already Opted In",
      textColor: Colors.white,
      textSize: 16.0,
      textWeight: FontWeight.w500,
      backgroundColor: Colors.grey,
    );
  }

  Widget _buildOptInButton() {
    return Container(
      child: InkWell(
        onTap: () async {
          final response = await ApiRepository.submitOptin(args);
          if (response.isSuccess!) {
            UiUtils.showToast("You Have Opted in");
            setState(() {
              _isOptedIn = true;
            });
          } else {
            UiUtils.showToast(response.error![MESSAGE]);
          }
        },
        child: UikButton(
          text: "OPT In",
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildServiceDetailsList() {
    return Container(
      child: Column(
        children: [
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
          final TemplateType templateType = _getTemplateType(type);

          switch (templateType) {
            case TemplateType.Image:
              final String imageUrl = template['imageUrl'];
              return Image.network(imageUrl);

            case TemplateType.BulletPoints:
              final String heading = template[Args.headingKey];
              final List<Map<String, dynamic>> bulletPoints =
                  (template[Args.bulletPointsKey] as List<dynamic>)
                      .cast<Map<String, dynamic>>();
              return BulletPointsCard(
                  heading: heading, bulletPoints: bulletPoints);

            case TemplateType.Video:
              final String videoUrl = template[Args.videoUrlKey];
              final UikVideoPlayerNewProps uikVideoPlayerProps =
                  UikVideoPlayerNewProps();
              uikVideoPlayerProps.id = "123";
              uikVideoPlayerProps.videoUrl = videoUrl;
              uikVideoPlayerProps.showVideoProgressIndicator = true;
              uikVideoPlayerProps.aspectRatio = 1.77;
              uikVideoPlayerProps.progressIndicatorColor = Colors.red;

              return Container(
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
                    UikVideoPlayerNew(
                        WidgetType.UikVideoPlayer, uikVideoPlayerProps),
                  ],
                ),
              );

            case TemplateType.Unknown:
              return const SizedBox();
          }
        }).toList(),
      ),
    );
  }

  TemplateType _getTemplateType(String type) {
    switch (type.toUpperCase()) {
      case Args.typeImage:
        return TemplateType.Image;
      case Args.typeBulletPoints:
        return TemplateType.BulletPoints;
      case Args.typeVideo:
        return TemplateType.Video;
      default:
        return TemplateType.Unknown;
    }
  }

  Widget _buildLoadingIndicator() {
    return const Center(
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
            _scrollController.jumpTo(ind * 100);
            break;
          case 1:
            _scrollController.jumpTo(ind * 400);
            break;
          default:
            _scrollController.jumpTo(ind * 320);
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

  const BulletPointsCard(
      {super.key, required this.heading, required this.bulletPoints});

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
          Align(
            alignment: Alignment.topCenter, // Align chevron to the top
            child: Icon(
              Icons.chevron_right,
              size: fontSize,
            ),
          ),
          const SizedBox(
              width: 8), // Add some spacing between the icon and text
          Expanded(
            child: Text(
              point,
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
