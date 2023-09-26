import 'package:flutter/material.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../Widgets/UikMaterialListTile/UikMaterialListTile.dart';
import '../../utils/network/ApiRepository.dart';
import 'package:google_fonts/google_fonts.dart';


class PartnerTrainingListDetailsWidget extends StatefulWidget {
  final dynamic args;
  const PartnerTrainingListDetailsWidget({this.args, Key? key});

  @override
  State<PartnerTrainingListDetailsWidget> createState() =>
      _PartnerTrainingListDetailsWidgetState(args: args);
}

class _PartnerTrainingListDetailsWidgetState
    extends State<PartnerTrainingListDetailsWidget> {
  late Future<ApiResponse> _trainingData;
  late dynamic args;

  _PartnerTrainingListDetailsWidgetState({this.args});

  @override
  void initState() {
    super.initState();
    _trainingData = ApiRepository.getAcademyDataByType(args);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _trainingData,
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }
        dynamic data = snap.data?.data;
        return SingleChildScrollView(
          physics:
          BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              _buildHeaderImage(data),
              const SizedBox(height: 8),
              ..._buildMaterialListTiles(data),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }

  Widget _buildHeaderImage(dynamic data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              data["image"],
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data["title"]}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${data["description"]}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMaterialListTiles(dynamic data) {
    return List<Widget>.generate(
      (data["materials"] as List).length,
          (index) {
        dynamic tileData = data["materials"][index];

        return Card(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TrainingCourseMaterialListTile(
              tileData: tileData,
            ),
          ),
        );
      },
    ).toList();
  }
}


dynamic samplePartnerTrainingData = {
  "isSuccess": true,
  "data": {
    "response": {
      "name": "Archive",
      "image": "https://images.indianexpress.com/2022/10/Kohli-30.jpg",
      "title": "How to Become Fingpay agent",
      "description":
          "A Practical Guide to understand the Step by Step process to sell Credit Card Smartly",
      "materials": [
        {
          "materialId": 1,
          "material_data": {
            "title": "Database Design Fundamentals",
            "description": "Learn the basics of designing efficient databases",
            "duration": "5 weeks",
            "instructor": "David Johnson",
            "dateTime": "60 minutes",
            "thumbnail":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "logo":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "action": {
              "type": "OPEN_WEB",
              "text": "PLAY",
              "data": {
                "url":
                    "https://docs.google.com/document/d/1W6wfYW69wOvsYfzN3QaG6AtsSq6TKbWrZcXnOIP3B8I/edit#heading=h.n2j26c77qltl"
              }
            }
          },
          "material_type": "DOCUMENT",
          "service_id": 1,
          "academy_id": 2
        },
        {
          "materialId": 2,
          "material_data": {
            "title": "Web Developement",
            "description": "Learn the basics of Web Dev",
            "duration": "4 weeks",
            "instructor": "Sanket Singh",
            "dateTime": "30 minutes",
            "thumbnail":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "logo":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "action": {
              "type": "OPEN_WEB",
              "text": "PLAY",
              "data": {"url": "https://meet.google.com/zqz-frvv-fdw"}
            }
          },
          "material_type": "LIVE",
          "service_id": 1,
          "academy_id": 1
        },
        {
          "materialId": 4,
          "material_data": {
            "title": "Learn Web Development and Get Hired in 2023",
            "description":
                "Learn Web Development and Get Hired in 2023 | Tanay Pratap",
            "instructor": "Tanay Pratap",
            "dateTime": "45 minutes",
            "duration": "6 weeks",
            "thumbnail": "https://i.ytimg.com/vi/TLacepiMuqk/maxresdefault.jpg",
            "logo":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSrDmV9e39L-T1mHzgBPiD7FrlyVC8-UXSq3rcjnoviQ&sg",
            "action": {
              "type": "OPEN_VIDEO",
              "text": "PLAY",
              "data": {"url": "https://www.youtube.com/watch?v=y2omP4c7WKw"}
            }
          },
          "material_type": "VIDEO",
          "service_id": 2,
          "academy_id": 2
        },
        {
          "materialId": 5,
          "material_data": {
            "title": "Complete Operating Systems in 1 Shot ",
            "description":
                "Complete Operating Systems in 1 Shot (With Notes) || For Placement Interviews",
            "instructor": "Love Babbar",
            "dateTime": "30 minutes",
            "duration": "4 weeks",
            "thumbnail":
                "https://media.licdn.com/dms/image/D4D22AQEN1w--7cGfzQ/feedshare-shrink_800/0/1686055987848?e=1697068800&v=beta&t=6DEb_38-jYVCp9wTFWBFG_wnj02J8-aQcOxZGhOyvVQ",
            "logo":
                "https://codehelp.s3.ap-south-1.amazonaws.com/medium_zbsjwp6ddviegs1oyrku_d40a8d6585.jpg",
            "action": {
              "type": "OPEN_WEB",
              "text": "PLAY",
              "data": {"url": "https://www.youtube.com/watch?v=3obEP8eLsCw"}
            }
          },
          "material_type": "VIDEO",
          "service_id": 3,
          "academy_id": 3
        },
        {
          "materialId": 6,
          "material_data": {
            "title": "How To Make Write Choice",
            "description":
                "How To Make The Right Choice? By Sandeep Maheshwari | Hindi",
            "duration": "6 weeks",
            "instructor": "Sandeep Maheshwari",
            "dateTime": "45 minutes",
            "thumbnail":
                "https://i.pinimg.com/736x/60/e9/8e/60e98ecebba14e48598fdc2dc8287713.jpg",
            "logo":
                "https://w7.pngwing.com/pngs/374/476/png-transparent-artist-sandeep-maheshwari-youtuber-entertainment-indian-celebrity-celebrity-indian-man-famous-people-video-creator-content-creator.png",
            "action": {
              "type": "OPEN_PAGE",
              "text": "PLAY",
              "data": {
                "url":
                    "https://lokalcompanyin/trainingCourse?training_courseId=1"
              }
            }
          },
          "material_type": "COURSE",
          "service_id": 2,
          "academy_id": 5
        },
        {
          "materialId": 7,
          "material_data": {
            "title": "Never forget who you are!",
            "description":
                "Never forget who you are! || Acharya Prashant (2019)",
            "instructor": "Acharya Prashant",
            "dateTime": "60 minutes",
            "duration": "8 weeks",
            "thumbnail":
                "https://s3.ap-south-1.amazonaws.com/live-ceekr/webroot/uploads/photos/thumbnail/2019/02/02/8467/850_15bc575c28ecbeee0c98bc75a7f3b76e.png",
            "logo":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZKT3pHB36_urvCxYf3tzjWK19Hj-W1qpFWjgUn2VUiw&s",
            "action": {
              "type": "OPEN_VIDEO",
              "text": "PLAY",
              "data": {"url": "https://www.youtube.com/watch?v=3obEP8eLsCw"}
            }
          },
          "material_type": "VIDEO",
          "service_id": 3,
          "academy_id": 5
        },
      ]
    }
  }
};

