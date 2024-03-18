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

class DeliveryJobDetailsScreen extends StatefulWidget {
  final dynamic args;

  DeliveryJobDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  _DeliveryJobDetailsScreenState createState() => _DeliveryJobDetailsScreenState();
}

class _DeliveryJobDetailsScreenState extends State<DeliveryJobDetailsScreen> {
  bool showFullDescription = false;
  bool _isLoading = true;
  Map<String, dynamic> deliveryJobDetail = {};
  Map<String, dynamic> metaData = {};
  List<dynamic> _ctas = [];

  @override
  void initState() {
    super.initState();
    _fetchServiceDetails();
  }

  // @override
  // void didChangeDependencies() {
  //   _fetchServiceDetails();
  //   super.didChangeDependencies();
  // }

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
        deliveryJobDetail = response.data!["deliveryJobDetail"] as Map<String, dynamic>;
         metaData = response.data['metaData'] as Map<String, dynamic>;
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
    String? url = metaData["logo"];
    String? jobName = deliveryJobDetail["jobProfile"];
    String? companyName = deliveryJobDetail["companyName"];
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

  Widget _buildEarningDetails() {
    String perPacketCharge = deliveryJobDetail["perPacketCharge"] ?? "";
    String dailyAvgVol = deliveryJobDetail["dailyAvgVol"] ?? "";
    String incomeCycle = deliveryJobDetail["incomeCycle"] ?? "";

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          color: '#F5F7FA'.toColor(),
          width: double.maxFinite,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Per Packet Charges",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: UikColor.giratina_500.toColor(),
                    ),
                  ),
                  Text(
                    perPacketCharge,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: UikColor.giratina_500.toColor(),
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 8),
                width: double.maxFinite,
                color: UikColor.giratina_400.toColor(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Average Volume",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: UikColor.giratina_500.toColor(),
                    ),
                  ),
                  Text(
                    dailyAvgVol,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: UikColor.giratina_500.toColor(),
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
        (incomeCycle.isNotEmpty && incomeCycle != "NA")
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
                  incomeCycle,
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

  Widget _buildEarningInfo() {
    String education = deliveryJobDetail['education'] ?? "";
    String deliveryRange = deliveryJobDetail['kmRange'] ?? "";
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (education.isNotEmpty && education != "NA")
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Education- ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: UikColor.giratina_500.toColor(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          education,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (deliveryRange.isNotEmpty && deliveryRange != "NA")
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Range- ',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: UikColor.giratina_500.toColor(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        deliveryRange,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 20),
          _buildEarningDetails(),
        ],
      ),
    );
  }

  Widget _buildJobHighlights() {
    List<String> jobHighlights = List<String>.from(
        deliveryJobDetail['jobHighlights'] ?? []);
    return (jobHighlights!=null && jobHighlights.isNotEmpty)
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
    String? jobDescription = deliveryJobDetail['jobDescription'];
    String? jdUrl = deliveryJobDetail['jdUrl'];
    return ((jobDescription!=null && jobDescription.isNotEmpty && jobDescription != "NA") ||
            (jdUrl!=null && jdUrl.isNotEmpty && jdUrl != "NA"))
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
                    (jdUrl!=null && jdUrl!.isNotEmpty && jdUrl != "NA")
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
                  jobDescription!,
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildDataBlock1() {
    Map<String, dynamic> dataBlockDisplayText = deliveryJobDetail['dataBlock1'];
    Map<String, dynamic> dataBlockItems = deliveryJobDetail['dataBlock1']["items"];
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataBlockDisplayText['displayText'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: UikColor.black.toColor(),
            ),
          ),
          SizedBox(height: 10),
          _showItemsDetails(
              items: dataBlockItems,
              heading: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildDataBlock2() {
    Map<String, dynamic> dataBlockDisplayText = deliveryJobDetail['dataBlock2'];
    Map<String, dynamic> dataBlockItems = deliveryJobDetail['dataBlock2']["items"];
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            dataBlockDisplayText['displayText'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: UikColor.black.toColor(),
            ),
          ),
          SizedBox(height: 10),
          _showItemsDetails(
              items: dataBlockItems,
              heading: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _showItemsDetails({
    required Map<String, dynamic> items,
    TextStyle? heading,
    TextStyle? body,
  }) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 24.0,
      children: items.entries.map((entry) {
        String displayText = entry.value['displayText'];
        String value = entry.value['value'];

        return SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 12),
                child: Text(
                  displayText,
                  style:  GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: UikColor.giratina_500.toColor(),
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: UikColor.giratina_100.toColor(),
                ),
                child: Text(
                  value,
                  style: (body == null)
                      ? GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )
                      : body,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget _buildInterviewDetails() {
  //   var interviewDetails =
  //       (deliveryJobDetail['interviewDetails'] as Map<String, dynamic>);
  //   interviewDetails.removeWhere(
  //       (key, value) => value == null || value == 'NA' || value == '');
  //   return (interviewDetails.isNotEmpty)
  //       ? Container(
  //           padding: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Interview Details ',
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               _showTypesAndDetails(map: interviewDetails),
  //               SizedBox(height: 8),
  //             ],
  //           ),
  //         )
  //       : Container();
  // }

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
                    String shareText = deliveryJobDetail['share'] ?? "";
                    String shareUrl = deliveryJobDetail['shareUrl'] ?? "";

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
                  _buildEarningInfo(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDataBlock1(),
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
                      _buildDataBlock2()
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
