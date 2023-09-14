import 'package:flutter/material.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UikButton/UikButton.dart';

class TrainingCourseMaterialListTile extends StatelessWidget {
  final dynamic tileData;
  const TrainingCourseMaterialListTile({required this.tileData, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Image.network(
        tileData["material_data"]["logo"],
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      ),
      title: _getTitle(),
      subtitle: _getSubTitle(),
    );
  }

  Widget _getTitle() {
    switch (tileData["material_data"]["action_text"]) {
      case "PLAY":
        {
          return Text(
            'Lesson ${tileData["material_id"]}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              color: "#BDBDBD".toColor(),
            ),
          );
        }
      default:
        {
          return Text(
            '${tileData["material_data"]["title"]}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 14.0,
              color: "#212121".toColor(),
            ),
          );
        }
    }
  }

  Widget _getSubTitle() {
    switch (tileData["material_data"]["action_text"]) {
      case "PLAY":
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tileData["material_data"]["title"]}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                  color: "#212121".toColor(),
                ),
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
                onClick: () {},
              ),
            ],
          );
        }
      case "WATCH":
        {
          return Column(
            children: [
              Text(
                '${tileData["material_data"]["duration"]}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: "#BDBDBD".toColor(),
                ),
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
                onClick: () {},
              ),
            ],
          );
        }
      default:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tileData["material_data"]["duration"]}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: "#BDBDBD".toColor(),
                ),
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
                onClick: () {},
              ),
            ],
          );
        }
    }
  }
}
