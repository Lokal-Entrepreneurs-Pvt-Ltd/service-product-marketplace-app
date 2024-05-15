import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

class GoldPassScreen extends StatefulWidget {
  final dynamic args;

  const GoldPassScreen({Key? key, required this.args}) : super(key: key);
  @override
  State<GoldPassScreen> createState() => _GoldPassScreenState();
}

class _GoldPassScreenState extends State<GoldPassScreen> {
  late Future<ApiResponse> apiResponse;
  @override
  void initState() {
    apiResponse = ApiRepository.getGoldPass(widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiResponse,
        builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final map = snapshot.data?.data;
            return Scaffold(
              appBar: GoldPassAppBar(
                  percent: map["percent"],
                  headerImage: map["headerImage"] ??
                      "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1711024099801-Gold%20Membership.png"),
              body: SingleChildScrollView(
                child: Column(
                    children:
                        List<dynamic>.from(map['data']).map<Widget>((entry) {
                  final String title = entry['title'];
                  final List<dynamic> value = entry['value'];
                  return CustomExpandableWidget(
                    isExpanded: true,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 8, top: 16),
                    title: Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    child: value.map<Widget>((data) {
                      final String boxTitle = data['title'] ?? "";
                      var boxValues = data['value'];
                      if (boxValues is List) {
                        boxValues = List<String>.from(data["value"]);
                      } else {
                        boxValues = data["value"] as String;
                      }
                      final String type = data['type'] ?? "";
                      if (type == "box") {
                        return box(boxTitle, boxValues);
                      } else if (type == "faq") {
                        return Column(
                          children: [
                            CustomExpandableWidget(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              margin: const EdgeInsets.only(
                                bottom: 4,
                                left: 0,
                                right: 38,
                              ),
                              isborder: false,
                              icon: SvgPicture.network(
                                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1711108758769-Vector.svg",
                                height: 6,
                                width: 6,
                              ),
                              title: Text(
                                boxTitle,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              child: [
                                Text(
                                  boxValues,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.only(top: 10),
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '•  ',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '$boxValues',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }).toList()),
              ),
            );
          }
        });
  }

  Widget _buildLoadingIndicator() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.yellow,
        ),
      ),
    );
  }

  Widget box(String title, List<String> list) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: double.maxFinite,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: "#E0E0E0".toColor(),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ...list
              .map(
                (text) => Row(
                  children: [
                    const Icon(
                      Icons.chevron_right,
                      size: 10,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          text,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class GoldPassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? percent;
  final String? headerImage;
  const GoldPassAppBar({super.key, required this.percent, required this.headerImage});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("#212121"),
      elevation: 0,
      leading: IconButton(
        iconSize: 24,
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 93,
              width: double.infinity,
              child: Image.network(
                headerImage!,
                fit: BoxFit.cover,
                height: 153,
                width: double.infinity,
              ),
            ),
            (percent != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 25),
                    child: CustomLinearPercentIndicator(
                      percent: percent!,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 220);
}

class CustomLinearPercentIndicator extends StatefulWidget {
  final double percent;
  final double height;
  final double lineHeight;

  const CustomLinearPercentIndicator({
    Key? key,
    required this.percent,
    this.height = 72,
    this.lineHeight = 8,
  }) : super(key: key);

  @override
  _CustomLinearPercentIndicatorState createState() =>
      _CustomLinearPercentIndicatorState();
}

class _CustomLinearPercentIndicatorState
    extends State<CustomLinearPercentIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<double> progress = [30, 60, 90];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _animation =
        Tween<double>(begin: 0.0, end: widget.percent).animate(_controller)
          ..addListener(() {
            setState(() {}); // Rebuild the widget when animation value changes
          });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    double getPosition(
        double percent, double targetPercent, double iconWidth) {
      final targetWidth = targetPercent * width - (iconWidth / 2);
      return targetWidth;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: widget.height,
          alignment: Alignment.center,
          child: LinearPercentIndicator(
            lineHeight: widget.lineHeight,
            percent: widget.percent,
            backgroundColor: UikColor.giratina_500.toColor(),
            progressColor: Colors.blue,
            barRadius: const Radius.circular(100),
            alignment: MainAxisAlignment.center,
            animation: true,
            padding: const EdgeInsets.all(0),
            animationDuration: 5000,
          ),
        ),
        for (double x in progress)
          Positioned(
            top: 36 - 4,
            left: getPosition(widget.percent, x / 100, 8),
            child: const Icon(
              Icons.do_not_disturb_on,
              color: Colors.white,
              size: 8,
            ),
          ),
        ...progress.map(
          (double day) {
            return Positioned(
              top: (_animation.value <= (day / 100 - 0.15) ||
                      _animation.value >= (day / 100 + 0.15))
                  ? 0
                  : null,
              bottom: (_animation.value > (day / 100 - 0.15) &&
                      _animation.value < (day / 100 + 0.15))
                  ? 0
                  : null,
              left: getPosition(widget.percent, day / 100, 50),
              child: Text(
                "Day ${day.round()}",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: UikColor.giratina_500.toColor(),
                ),
              ),
            );
          },
        ).toList(),
        Positioned(
          top: 0,
          left: getPosition(widget.percent, _animation.value, 68),
          child: Image.network(
            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1711082031859-icons8-delivery-scooter-188%201.png",
            height: 34,
            width: 34,
          ),
        ),
      ],
    );
  }
}

class CustomExpandableWidget extends StatefulWidget {
  final bool isborder;
  final bool isExpanded;
  final Widget? icon;
  final Widget title;
  final List<Widget> child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const CustomExpandableWidget({super.key, 
    required this.title,
    this.isborder = true,
    this.isExpanded = true,
    this.icon,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    required this.child,
  });

  @override
  _CustomExpandableWidgetState createState() => _CustomExpandableWidgetState();
}

class _CustomExpandableWidgetState extends State<CustomExpandableWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        children: [
          if (widget.isborder)
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    UikColor.giratina_500.toColor(),
                    UikColor.giratina_500.toColor().withOpacity(0.5),
                    UikColor.giratina_500.toColor().withOpacity(0.2),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          GestureDetector(
            onTap: toggleExpansion,
            child: Container(
              padding: widget.padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.title,
                  isExpanded
                      ? Transform.rotate(
                          angle: 22 / 7,
                          child: widget.icon ??
                              SvgPicture.network(
                                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1711101640614-chevron-down.svg",
                              ),
                        )
                      : widget.icon ??
                          SvgPicture.network(
                            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1711101640614-chevron-down.svg",
                          ),
                ],
              ),
            ),
          ),
          if (widget.isborder)
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    UikColor.giratina_500.toColor(),
                    UikColor.giratina_500.toColor().withOpacity(0.5),
                    UikColor.giratina_500.toColor().withOpacity(0.2),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          if (isExpanded) ...widget.child,
        ],
      ),
    );
  }
}
