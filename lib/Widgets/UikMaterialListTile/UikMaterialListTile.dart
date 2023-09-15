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
  const TrainingCourseMaterialListTile({required this.tileData, super.key});

  void _actionHandler(dynamic action, BuildContext ctx) {
    UikAction_Tap uikAction = UikAction_Tap.fromJson(action);

    // UikAction  = UikAction.fromJson(action);
    if (uikAction.data.url != null) {
      switch (uikAction.type) {
        case UIK_ACTION.OPEN_PAGE:
          {
            DeeplinkHandler.openPage(
              ctx,
              uikAction.data.url!,
            );
            return;
          }

        case UIK_ACTION.OPEN_VIDEO:
          {
            DeeplinkHandler.openPage(
              ctx,
              uikAction.data.url!,
            );
            return;
          }

        case UIK_ACTION.OPEN_WEB:
          {
            DeeplinkHandler.openPage(
              ctx,
              uikAction.data.url!,
            );
            return;
          }
      }
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
    // UiSdkUtils.prettyPrintJson(tileData);

    switch (tileData["material_type"]) {
      case "VIDEO":
        {
          return Text(
            'Lesson ${tileData["materialId"]}',
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

  Widget _getSubTitle(BuildContext context) {
    switch (tileData["material_type"]) {
      case "VIDEO":
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
                onClick: () {
                  _actionHandler(tileData["material_data"]["action"], context);
                },
              ),
            ],
          );
        }
      case "COURSE":
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tileData["material_data"]["dateTime"]}',
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
      case "DOCUMENT":
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tileData["material_data"]["dateTime"]}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: "#BDBDBD".toColor(),
                ),
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
                      _actionHandler(
                          tileData["material_data"]["action"], context);
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
                          _actionHandler(
                              tileData["material_data"]["action"], context);
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
      case "LIVE":
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tileData["material_data"]["dateTime"]}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: "#BDBDBD".toColor(),
                ),
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
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: "#4CAF50".toColor(),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Starts in ${tileData["material_data"]["dateTime"]}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: "#BDBDBD".toColor(),
                    ),
                  ),
                ],
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
                '${tileData["material_data"]["dateTime"]}',
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
                onClick: () {
                  _actionHandler(tileData["material_data"]["action"], context);
                },
              ),
            ],
          );
        }
    }
  }
}


/**
 {
    "materialId": 1,
    "material_data": {
    "title": "Database Design Fundamentals",
    "description": "Learn the basics of designing efficient databases",
     "duration": "5 weeks",
    "instructor": "David Johnson",
    "dateTime": "60 minutes",
    "thumbnail": "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
     "logo": "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
  "action": {
      "type": "OPEN_WEB",
      "text": "PLAY",
        "data": {
                "url": "https://docs.google.com/document/d/1W6wfYW69wOvsYfzN3QaG6AtsSq6TKbWrZcXnOIP3B8I/edit#heading=h.n2j26c77qltl"
        }
  }
  },
  "material_type": "DOCUMENT",
  "service_id": 1,
  "academy_id": 2
}
----------------------
{
    "materialId": 2,
    "material_data": {
    "title": "Web Developement",
    "description": "Learn the basics of Web Dev",
     "duration": "4 weeks",
    "instructor": "Sanket Singh",
    "dateTime": "30 minutes",
    "thumbnail": "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
     "logo": "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
  "action": {
      "type": "OPEN_WEB",
      "text": "PLAY",
        "data": {
                "url": "https://meet.google.com/zqz-frvv-fdw"
        }
  }
  },
  "material_type": "LIVE",
  "service_id": 1,
  "academy_id": 1
}
---------------------------------
{
    "materialId": 4,
    "material_data": {
    "title": "Learn Web Development and Get Hired in 2023",
    "description": "Learn Web Development and Get Hired in 2023 | Tanay Pratap",
    "instructor": "Tanay Pratap",
    "dateTime": "45 minutes",
    "duration": "6 weeks",
    "thumbnail": "https://i.ytimg.com/vi/TLacepiMuqk/maxresdefault.jpg",
     "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSrDmV9e39L-T1mHzgBPiD7FrlyVC8-UXSq3rcjnoviQ&sg",
  "action": {
      "type": "OPEN_VIDEO",
      "text": "PLAY",
        "data": {
                "url": "https://www.youtube.com/watch?v=y2omP4c7WKw"
        }
  }
  },
  "material_type": "VIDEO",
   "service_id": 2,
   "academy_id": 2
}
---------------------------------
{
    "materialId": 5,
    "material_data": {
    "title": "Complete Operating Systems in 1 Shot ",
    "description": "Complete Operating Systems in 1 Shot (With Notes) || For Placement Interviews",
    "instructor": "Love Babbar",
    "dateTime": "30 minutes",
    "duration": "4 weeks",
    "thumbnail": "https://media.licdn.com/dms/image/D4D22AQEN1w--7cGfzQ/feedshare-shrink_800/0/1686055987848?e=1697068800&v=beta&t=6DEb_38-jYVCp9wTFWBFG_wnj02J8-aQcOxZGhOyvVQ",
     "logo": "https://codehelp.s3.ap-south-1.amazonaws.com/medium_zbsjwp6ddviegs1oyrku_d40a8d6585.jpg",
  "action": {
      "type": "OPEN_WEB",
      "text": "PLAY",
        "data": {
                "url": "https://www.youtube.com/watch?v=3obEP8eLsCw"
        }
  }
  },
  "material_type": "VIDEO",
  "service_id": 3,
  "academy_id": 3
}
--------------------------------
{
    "materialId": 6,
    "material_data": {
    "title": "How To Make Write Choice",
    "description": "How To Make The Right Choice? By Sandeep Maheshwari | Hindi",
     "duration": "6 weeks",
    "instructor": "Sandeep Maheshwari",
    "dateTime": "45 minutes",
    "thumbnail": "https://i.pinimg.com/736x/60/e9/8e/60e98ecebba14e48598fdc2dc8287713.jpg",
     "logo": "https://w7.pngwing.com/pngs/374/476/png-transparent-artist-sandeep-maheshwari-youtuber-entertainment-indian-celebrity-celebrity-indian-man-famous-people-video-creator-content-creator.png",
  "action": {
      "type": "OPEN_PAGE",
      "text": "PLAY",
        "data": {
                "url": "https://lokalcompanyin/trainingCourse?training_courseId=1"
        }
  }
  },
  "material_type": "COURSE",
 "service_id": 2,
 "academy_id": 5
}
------------------
{
    "materialId": 7,
    "material_data": {
    "title": "Never forget who you are!",
    "description": "Never forget who you are! || Acharya Prashant (2019)",
    "instructor": "Acharya Prashant",
    "dateTime": "60 minutes",
    "duration": "8 weeks",
    "thumbnail": "https://s3.ap-south-1.amazonaws.com/live-ceekr/webroot/uploads/photos/thumbnail/2019/02/02/8467/850_15bc575c28ecbeee0c98bc75a7f3b76e.png",
     "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZKT3pHB36_urvCxYf3tzjWK19Hj-W1qpFWjgUn2VUiw&s",
  "action": {
      "type": "OPEN_VIDEO",
      "text": "PLAY",
        "data": {
                "url": "https://www.youtube.com/watch?v=3obEP8eLsCw"
        }
  }
  },
  "material_type": "VIDEO",
 "service_id": 3,
 "academy_id": 5
}
      
 */