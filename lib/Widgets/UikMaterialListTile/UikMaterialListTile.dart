import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/utils/UiSdkUtils.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UikButton/UikButton.dart';

enum MaterialType {
  VIDEO,
  COURSE,
  LIVE,
  DOCUMENT,
}

class TrainingCourseMaterialListTile extends StatelessWidget {
  final dynamic tileData;
  const TrainingCourseMaterialListTile({required this.tileData, Key? key}) : super(key: key);

  void _actionHandler(dynamic action, BuildContext ctx) {
    final UikAction_Tap uikAction = UikAction_Tap.fromJson(action);

    if (uikAction.data.url != null) {
      DeeplinkHandler.openPage(ctx, uikAction.data.url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      isThreeLine: false,
      leading: Image.network(
        tileData["material_data"]["logo"],
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      ),
      title: _getTitle(),
      subtitle: _getSubTitle(context),
    );
  }

  Widget _getTitle() {
    switch (tileData["material_type"]) {
      case "VIDEO":
        return Text(
          'Lesson ${tileData["materialId"]}',
          style: _textStyle(12.0, "#BDBDBD".toColor()),
        );
      default:
        return Text(
          '${tileData["material_data"]["title"]}',
          style: _textStyle(14.0, "#212121".toColor(), FontWeight.w300),
        );
    }
  }

  Widget _getSubTitle(BuildContext context) {
    switch (tileData["material_type"]) {
      case "VIDEO":
        return _videoSubtitle(context);
      case "COURSE":
        return _courseSubtitle(context);
      case "DOCUMENT":
        return _documentSubtitle(context);
      case "LIVE":
        return _liveSubtitle(context);
      default:
        return _defaultSubtitle(context);
    }
  }

  Widget _videoSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tileData["material_data"]["title"]}',
          style: _textStyle(14.0, "#212121".toColor(), FontWeight.w300),
        ),
        const SizedBox(height: 8),
        UikButton(
          widthSize: 70,
          heightSize: 21,
          backgroundColor: "#FEE440".toColor(),
          textColor: "#212121".toColor(),
          text: "Play",
          textSize: 12.0,
          textWeight: FontWeight.w400,
          onClick: () {
            _actionHandler(tileData["material_data"]["action"], context);
          },
        ),
      ],
    );
  }

  Widget _courseSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tileData["material_data"]["dateTime"]}',
          style: _textStyle(12.0, "#BDBDBD".toColor()),
        ),
        const SizedBox(height: 8),
        UikButton(
          widthSize: 70,
          heightSize: 21,
          backgroundColor: "#FEE440".toColor(),
          textColor: "#212121".toColor(),
          text: "Watch",
          textSize: 12.0,
          textWeight: FontWeight.w400,
          onClick: () {
            _actionHandler(tileData["material_data"]["action"], context);
          },
        ),
      ],
    );
  }

  Widget _documentSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tileData["material_data"]["dateTime"]}',
          style: _textStyle(12.0, "#BDBDBD".toColor()),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UikButton(
              widthSize: 70,
              heightSize: 21,
              backgroundColor: "#FEE440".toColor(),
              textColor: "#212121".toColor(),
              text: "Register",
              textSize: 12.0,
              textWeight: FontWeight.w400,
              onClick: () {
                _actionHandler(tileData["material_data"]["action"], context);
              },
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                UikButton(
                  widthSize: 130,
                  heightSize: 16,
                  backgroundColor: Colors.white,
                  textColor: "#3F51B5".toColor(),
                  text: "Download Docs",
                  textSize: 12.0,
                  textWeight: FontWeight.w400,
                  onClick: () {
                    _actionHandler(tileData["material_data"]["action"], context);
                  },
                  stuck: true,
                  rightElement: Icon(
                    Icons.download,
                    color: "#3F51B5".toColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _liveSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tileData["material_data"]["dateTime"]}',
          style: _textStyle(12.0, "#BDBDBD".toColor()),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.thumb_up_alt_outlined,
                  color: "#4CAF50".toColor(),
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  'Registered',
                  style: _textStyle(12.0, "#4CAF50".toColor()),
                ),
              ],
            ),
            Text(
              'Starts in ${tileData["material_data"]["dateTime"]}',
              style: _textStyle(12.0, "#BDBDBD".toColor()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _defaultSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tileData["material_data"]["dateTime"]}',
          style: _textStyle(12.0, "#BDBDBD".toColor()),
        ),
        const SizedBox(height: 8),
        UikButton(
          widthSize: 70,
          heightSize: 21,
          backgroundColor: "#FEE440".toColor(),
          textColor: "#212121".toColor(),
          text: "Play",
          textSize: 12.0,
          textWeight: FontWeight.w400,
          onClick: () {
            _actionHandler(tileData["material_data"]["action"], context);
          },
        ),
      ],
    );
  }

  TextStyle _textStyle(double fontSize, Color color, [FontWeight fontWeight = FontWeight.w400]) {
    return GoogleFonts.poppins(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }
}
