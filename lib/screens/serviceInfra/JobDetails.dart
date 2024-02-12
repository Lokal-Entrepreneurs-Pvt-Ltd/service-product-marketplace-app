import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/extensions.dart';

class JobDetailsScreen extends StatefulWidget {
  final dynamic args;
  JobDetailsScreen({super.key, this.args});

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  bool showFullDescription = false;
  int _currentTabNumber = 0;
  bool _isloading = true;
  Map<String, dynamic> jobDetails = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchServiceDetails();
  }

  @override
  void didChangeDependencies() {
    _fetchServiceDetails();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchServiceDetails() async {
    try {
      // final response = await ApiRepository.getServiceDetailsById(widget.args);
      setState(() {
        _isloading = true;
      });
      final response = await ApiRepository.getJobsbyId(widget.args);
      if (response.isSuccess!) {
        jobDetails = response.data["jobDetails"] as Map<String, dynamic>;
        jobDetails = jobDetails["job_details"];

        if (jobDetails['tabs'] != null) {
          _tabController =
              TabController(length: jobDetails['tabs'].length, vsync: this);
          _scrollController.addListener(() {
            if (_scrollController.offset > 150) {
              int newIndex =
                  ((_scrollController.offset - 100) * 2 / 265).round();
              if (newIndex != _currentTabNumber &&
                  newIndex < jobDetails['tabs'].length) {
                setState(() {
                  _currentTabNumber = newIndex;
                });
                _tabController.animateTo(newIndex);
              }
            }
          });
        }
        setState(() {
          _isloading = false;
        });
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

  TextStyle _getTabItemTextStyle(int index) {
    bool isSelected = _currentTabNumber == index;
    return GoogleFonts.poppins(
      color: isSelected ? Colors.black : Colors.grey.shade400,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildProfileInfo() {
    String? url = jobDetails["logo"];
    String? jobName = jobDetails["jobName"];
    String? companyName = jobDetails["companyName"];
    if (jobName != null && companyName != null) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 29,
              backgroundColor: Colors.amber[300],
              foregroundImage: (url != null) ? NetworkImage(url) : null,
              child: Text(
                companyName[0],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellowAccent, fontSize: 40),
              ),
            ),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  companyName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: UikColor.giratina_500.toColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget _buildSalaryDetails() {
    Map<String, dynamic> salaryDetails = jobDetails['salaryDetails'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: '#F5F7FA'.toColor(),
      width: double.maxFinite,
      child: Column(
        children: salaryDetails.entries.map((entry) {
          String key = entry.key;
          dynamic value = entry.value;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: UikColor.giratina_500.toColor(),
                    ),
                  ),
                  Text(
                    '$value',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: UikColor.giratina_500.toColor(),
                    ),
                  ),
                ],
              ),
              (entry.toString() !=
                      salaryDetails.entries.last
                          .toString()) // Add separator if not the last entry
                  ? Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      width: double.maxFinite,
                      color: UikColor.giratina_400.toColor(),
                    )
                  : Container(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationSalaryInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Work Location- ',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: UikColor.giratina_500.toColor(),
                ),
              ),
              Text(
                '${jobDetails['location']}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Salary- ',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: UikColor.giratina_500.toColor(),
                ),
              ),
              Text(
                '${jobDetails['salary']}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildSalaryDetails(),
        ],
      ),
    );
  }

  Widget _buildJobHighlights() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: '#F5F7FA'.toColor(),
        border: Border.all(color: UikColor.gengar_300.toColor()),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job highlights ',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: UikColor.gengar_500.toColor(),
            ),
          ),
          SizedBox(height: 8),
          ...List<String>.from(
            jobDetails['Job Details']['jobHighlights'],
          ).map(
            (text) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: UikColor.giratina_500.toColor(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: UikColor.giratina_500.toColor(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDescription() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Description',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildExpandableText(
            // widget.jobDetails['Job Details']['jobDescription'],
            jobDetails['Job Details']['jobDescription'],
          ),
        ],
      ),
    );
  }

  Widget _buildJobRole() {
    Map<String, dynamic> jobrole = jobDetails['Job Role'];
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Role ',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ...jobrole.entries.map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.key as String,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: UikColor.giratina_500.toColor(),
                  ),
                ),
                Text(
                  e.value as String,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterviewDetails() {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interview Details ',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ...jobDetails['Interview Details'].entries.map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.key as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: UikColor.giratina_500.toColor(),
                      ),
                    ),
                    Text(
                      e.value as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildExpandableText(String text) {
    final int maxLines = showFullDescription ? 20 : 5;
    return Container(
      margin: EdgeInsets.only(right: 16, top: 4),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: UikColor.giratina_500.toColor(),
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
              if (text.length > 150)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFullDescription = !showFullDescription;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      showFullDescription ? 'Show less' : 'Show more',
                      style: GoogleFonts.poppins(
                        color: UikColor.gengar_500.toColor(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (text.length > 150 && !showFullDescription)
            Positioned(
              child: Container(
                width: double.maxFinite,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.55),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(1),
                      Colors.white.withOpacity(1)
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (!_isloading)
        ? _buildLoadingIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: "#F5F7FA".toColor(),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                InkWell(
                  onTap: () {
                    String shareText = jobDetails['share'];
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: UikColor.charizard_400.toColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(
                      children: [
                        Image.network(
                          "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1707203798704-ic_baseline-whatsapp.png",
                          width: 16,
                          height: 16,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Share",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: DefaultTabController(
              length: jobDetails['tabs'].length,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileInfo(),
                    Container(
                      height: 2,
                      width: double.maxFinite,
                      color: UikColor.giratina_100.toColor(),
                    ),
                    _buildLocationSalaryInfo(),
                    Container(
                      height: 6,
                      width: double.maxFinite,
                      color: UikColor.giratina_100.toColor(),
                    ),
                    Container(
                      height: 45,
                      child: TabBar(
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
                        isScrollable: true,
                        indicatorColor: UikColor.charizard_400.toColor(),
                        labelStyle: GoogleFonts.poppins(fontSize: 16),
                        controller: _tabController,
                        tabs: List<Widget>.from(jobDetails['tabs']
                            .map(
                              (tab) => Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    tab as String,
                                    style: _getTabItemTextStyle(
                                        jobDetails['tabs'].indexOf(tab)),
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // shrinkWrap: true,
                      // physics: AlwaysScrollableScrollPhysics(),
                      // controller: _scrollController,
                      children: [
                        _buildJobHighlights(),
                        Container(
                          height: 6,
                          //   margin: EdgeInsets.symmetric(vertical: 8),
                          width: double.maxFinite,
                          color: UikColor.giratina_100.toColor(),
                        ),
                        _buildJobDescription(),
                        Container(
                          height: 6,
                          //   margin: EdgeInsets.symmetric(vertical: 8),
                          width: double.maxFinite,
                          color: UikColor.giratina_100.toColor(),
                        ),
                        _buildJobRole(),
                        Container(
                          height: 6,
                          //   margin: EdgeInsets.symmetric(vertical: 8),
                          width: double.maxFinite,
                          color: UikColor.giratina_100.toColor(),
                        ),
                        _buildInterviewDetails(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: [_buildButton()],
          );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () async {
          // final response = await ApiRepository.submitOptin(widget.args);
          // if (response.isSuccess!) {
          //   UiUtils.showToast("You Have Opted in");
          //   setState(() {
          //     _isOptedIn = true;
          //   });
          // } else {
          //   UiUtils.showToast(response.error![MESSAGE]);
          // }
        },
        child: UikButton(
          text: "Apply Now",
          backgroundColor: UikColor.charizard_400.toColor(),
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
          stuck: true,
        ),
      ),
    );
  }
}
