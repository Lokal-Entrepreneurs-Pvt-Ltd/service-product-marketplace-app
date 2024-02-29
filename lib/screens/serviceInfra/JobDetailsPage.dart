import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/UikActionListner.dart';
import 'package:ui_sdk/utils/extensions.dart';

import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';

class JobDetailsScreen extends StatefulWidget {
  final dynamic args;

  JobDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool showFullDescription = false;
  bool _isLoading = true;
  Map<String, dynamic> jobPost = {};
  List<dynamic> _ctas = [];

  @override
  void initState() {
    super.initState();
    _fetchServiceDetails();
  }

  @override
  void didChangeDependencies() {
    _fetchServiceDetails();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchServiceDetails() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await ApiRepository.getJobsbyId(widget.args);
      if (response.isSuccess!) {
        jobPost = response.data!["jobPost"] as Map<String, dynamic>;
        final metaData = response.data['metaData'] as Map<String, dynamic>;
        _ctas = metaData['ctas'] as List<dynamic>;
        setState(() {
          _isLoading = false;
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

  Widget _buildProfileInfo() {
    String? url = jobPost["logo"];
    String? jobName = jobPost["jobName"];
    String? companyName = jobPost["companyName"];
    if (jobName != null && companyName != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708500398902-Rectangle%203220.png"),
              fit: BoxFit.fill),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 58,
                height: 58,
                color: Colors.white,
                child: Image.network(
                  url ?? "",
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      companyName[0],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobName,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
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
    Map<String, dynamic> salaryDetails = jobPost['salaryDetails'];
    String incentive = salaryDetails["incentive"] ?? "";
    if (salaryDetails.containsKey('incentive')) {
      salaryDetails.remove('incentive');
    }

    return Column(
      children: [
        Container(
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
                  (entry.toString() != salaryDetails.entries.last.toString())
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
        ),
        (incentive.isNotEmpty && incentive != "NA")
            ? Container(
                height: 28,
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708576145568-Rectangle%203220.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  incentive,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: UikColor.charizard_500.toColor(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _buildLocationSalaryInfo() {
    String education = jobPost['jobDetails']["education"] ?? "";
    String salary = jobPost['salary'] ?? "";
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (education.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        'Education- ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: UikColor.giratina_500.toColor(),
                        ),
                      ),
                      Text(
                        education,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (salary.isNotEmpty)
              ? Row(
                  children: [
                    Text(
                      'Salary- ',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: UikColor.giratina_500.toColor(),
                      ),
                    ),
                    Text(
                      salary,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 20),
          _buildSalaryDetails(),
        ],
      ),
    );
  }

  Widget _buildJobHighlights() {
    List<String> jobHighlights = List<String>.from(
      jobPost['jobDetails']['jobHighlights'],
    );
    return (jobHighlights.isNotEmpty)
        ? Container(
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
                ...jobHighlights.map(
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
          )
        : Container();
  }

  Widget _buildJobDescription() {
    String jobDescription = jobPost['jobDetails']['jobDescription'];
    String jdUrl = jobPost['jobDetails']['jdUrl'];
    return ((jobDescription.isNotEmpty && jobDescription != "NA") ||
            (jdUrl.isNotEmpty))
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Job Description',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    (jdUrl.isNotEmpty && jdUrl!="NA")
                        ? GestureDetector(
                            onTap: () {
                              launchURL(jdUrl);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: UikColor.gengar_500.toColor(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Download JD",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                _buildExpandableText(
                  jobDescription,
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildJobRole() {
    Map<String, dynamic> jobrole = jobPost['jobRole'];
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _showTypesAndDetails(
              map: jobrole,
              heading: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _showTypesAndDetails(
      {required Map<String, dynamic> map,
      TextStyle? heading,
      TextStyle? body}) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 24.0,
      children: map.entries
          .where((entry) =>
              (entry.value is String &&
                  (entry.value as String).isNotEmpty &&
                  (entry.value as String) != "NA") ||
              (entry.value is List<String> &&
                  ((entry.value as List<String>).isNotEmpty)))
          .map(
            (entry) => SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 12),
                    child: Text(
                      entry.key,
                      style: (heading == null)
                          ? GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: UikColor.giratina_500.toColor(),
                            )
                          : heading,
                    ),
                  ),
                  if (entry.value is String)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: UikColor.giratina_100.toColor(),
                      ),
                      child: Text(entry.value.toString(),
                          style: (body == null)
                              ? GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )
                              : body),
                    ),
                  if (entry.value is List<String>)
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: (entry.value as List<String>)
                          .map(
                            (item) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: UikColor.giratina_100.toColor(),
                              ),
                              child: Text(
                                item,
                                style: (body == null)
                                    ? GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      )
                                    : body,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildInterviewDetails() {
    var interviewDetails = jobPost['interviewDetails'] as Map<String, dynamic>;
    return (interviewDetails.isNotEmpty)
        ? Container(
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
                _showTypesAndDetails(map: interviewDetails),
                SizedBox(height: 8),
              ],
            ),
          )
        : Container();
  }

  Widget _buildExpandableText(String text) {
    final int maxLines = showFullDescription ? 20 : 5;
    return (text.isNotEmpty && text != "NA")
        ? Container(
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
                    Container(
                      height: 5,
                      width: double.maxFinite,
                    )
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
                if (text.length > 150)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showFullDescription = !showFullDescription;
                        });
                      },
                      child: Text(
                        showFullDescription ? 'Show less' : 'Show more',
                        style: GoogleFonts.poppins(
                          color: UikColor.venusaur_500.toColor(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        : Container();
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
    return (_isLoading)
        ? _buildLoadingIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: "#F5F7FA".toColor(),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                InkWell(
                  onTap: () {


                    String shareText = jobPost['share'] ?? "";
                    String shareUrl = jobPost['shareUrl'] ?? "";

                    UiUtils.shareOnWhatsApp(
                        shareUrl.isNotEmpty
                            ? shareUrl
                            : "https://play.google.com/store/apps/details?id=com.lokal.app&hl=en_US",
                        shareText.isNotEmpty
                            ? shareText
                            : "लोकल वोकल है: जुड़ें लोकल से पाये जॉब आपके घर के पास");
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
            body: SingleChildScrollView(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildJobRole(),
                      _buildJobHighlights(),
                      Container(
                        height: 6,
                        width: double.maxFinite,
                        color: UikColor.giratina_100.toColor(),
                      ),
                      _buildJobDescription(),
                      Container(
                        height: 6,
                        width: double.maxFinite,
                        color: UikColor.giratina_100.toColor(),
                      ),
                      _buildInterviewDetails(),
                    ],
                  ),
                ],
              ),
            ),
            persistentFooterButtons: _ctas
                    .where((element) => element["text"]?.isNotEmpty == true)
                    .isNotEmpty
                ? [_buildCtas()]
                : null,
          );
  }

  Widget _buildCtas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _ctas.asMap().entries.map<Widget>((entry) {
        int index = entry.key;
        Map<String, dynamic> cta = Map<String, dynamic>.from(entry.value);

        final String text = cta['text'];
        if (text.isEmpty) {
          return const SizedBox.shrink();
        }
        final Color textColor = Color(
            int.parse(cta['textColor'].substring(1), radix: 16) + 0xFF000000);
        final Color backgroundColor = index == 1
            ? Colors.grey
            : Color(int.parse(cta['backgroundColor'].substring(1), radix: 16) +
                0xFF000000);
        final Map<String, dynamic> action = cta['action'];
        final Map<String, dynamic> tap = action['tap'];
        final String actionType = tap['type'];
        final Map<String, dynamic> actionData = tap['data'];

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () async {
                switch (actionType) {
                  case "UIK_OPEN_WEB":
                    launchURL(actionData['url']);
                    break;
                  case "SHARE_WHATSAPP":
                    UiUtils.shareOnWhatsApp(
                        actionData['url'], actionData['message']);
                    break;
                  case "OPEN_PAGE":
                    NavigationUtils.openPageFromUrl(actionData['url']);
                    break;
                  default:
                    break;
                }
              },
              child: UikButton(
                text: text,
                textColor: textColor,
                textSize: 16.0,
                textWeight: FontWeight.w500,
                backgroundColor: backgroundColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
