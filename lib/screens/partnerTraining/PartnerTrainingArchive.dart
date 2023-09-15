import 'package:flutter/material.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../Widgets/UikMaterialListTile/UikMaterialListTile.dart';
import '../../utils/network/ApiRepository.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerTrainingArchiveScreen extends StatefulWidget {
  const PartnerTrainingArchiveScreen({Key? key});

  @override
  State<PartnerTrainingArchiveScreen> createState() =>
      _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends State<PartnerTrainingArchiveScreen> {
  late Future<ApiResponse> _trainingData;
  late dynamic args;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments;
    _trainingData = ApiRepository.getServiceTabsScreen(args);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null, // Use the stored future
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }
        // dynamic data = snap.data?.data;
        dynamic data = samplePartnerTrainingData["data"]['response'];

        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          appBar: _buildAppBar(data),
          body: Column(
            children: [
              Card(
                elevation: 0.0,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          data["image"],
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
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
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Card(
                  elevation: 0.0,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: ListView.builder(
                      itemCount: (data["materials"] as List).length,
                      itemBuilder: (ctx, index) {
                        dynamic tileData = data["materials"][index];

                        return TrainingCourseMaterialListTile(
                          tileData: tileData,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(dynamic data) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        "${data["name"]}",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
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
          "material_id": 1,
          "material_data": {
            "title": "Credit Card v/s Debit Card",
            "description": "Learn the basics of designing efficient databases.",
            "duration": "4 weeks",
            "date_time": "5 Sep 5 pm",
            "instructor": "David Johnson",
            "logo":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "thumbnail":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "action_text": "PLAY",
            "action": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://www.lokalcompany.in/samhitaLandingPage"}
            }
          },
          "material_type": "Course Material",
          "service_id": 1,
          "academy_id": 2
        },
        {
          "material_id": 1,
          "material_data": {
            "title": "Credit Card v/s Debit Card",
            "description": "Learn the basics of designing efficient databases.",
            "duration": "4 weeks",
            "date_time": "5 Sep 5 pm",
            "instructor": "David Johnson",
            "logo":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "thumbnail":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "action_text": "PLAY",
            "action": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://www.lokalcompany.in/samhitaLandingPage"}
            }
          },
          "material_type": "Course Material",
          "service_id": 1,
          "academy_id": 2
        },
        {
          "material_id": 1,
          "material_data": {
            "title": "Credit Card v/s Debit Card",
            "description": "Learn the basics of designing efficient databases.",
            "duration": "4 weeks",
            "date_time": "5 Sep 5 pm",
            "instructor": "David Johnson",
            "logo":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "thumbnail":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "action_text": "PLAY",
            "action": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://www.lokalcompany.in/samhitaLandingPage"}
            }
          },
          "material_type": "Course Material",
          "service_id": 1,
          "academy_id": 2
        },
        {
          "material_id": 1,
          "material_data": {
            "title": "Credit Card v/s Debit Card",
            "description": "Learn the basics of designing efficient databases.",
            "duration": "4 weeks",
            "date_time": "5 Sep 5 pm",
            "instructor": "David Johnson",
            "logo":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "thumbnail":
                "https://www.pngitem.com/pimgs/m/255-2550411_404-error-images-free-png-transparent-png.png",
            "action_text": "PLAY",
            "action": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://www.lokalcompany.in/samhitaLandingPage"}
            }
          },
          "material_type": "Course Material",
          "service_id": 1,
          "academy_id": 2
        },
      ]
    }
  }
};
