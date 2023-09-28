import 'package:flutter/material.dart';
import 'package:lokal/screens/partnerTraining/partnerTrainingListDetails.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../Widgets/UikCustomTabBar/customTabBar.dart';
import '../../utils/network/ApiRepository.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerTrainingHomeScreen extends StatefulWidget {
  const PartnerTrainingHomeScreen({super.key, Key? key});

  @override
  State<PartnerTrainingHomeScreen> createState() =>
      _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends State<PartnerTrainingHomeScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _currentIndex = 0;
  late Future<ApiResponse> _partnerTrainingApiData;
  late dynamic args;

  @override
  void didChangeDependencies() {
    // _tabController = TabController(length: 2, vsync: this);
    args = ModalRoute.of(context)?.settings.arguments;
    // _tabController.addListener(() {
    // setState(() {
    //   _currentIndex = _tabController.index;
    // });
    // });

    _partnerTrainingApiData = ApiRepository.getServiceTabsScreen(args);
    // Add a listener to the TabController to update the selected tab when scrolled

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
        dynamic data = sampleData['data']['response'];

        _tabController ??=
            TabController(length: (data["tabs"] as List).length, vsync: this);

        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          appBar: _buildAppBar(data),
          body: Column(
            children: [
              // Image
              Image.network(
                data["image"],
                fit: BoxFit.cover,
                height: 153,
                width: double.infinity,
              ),

              // Tabbar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    TabBar(
                      onTap: (ind) {
                        setState(() {
                          _currentIndex = ind;
                          // debugPrint(_tabController!.index.toString());
                        });
                      },
                      controller: _tabController,
                      indicatorColor: const Color(0xFF3F51B5),
                      indicatorWeight: 2.5,
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      tabs: List.generate(
                        (data["tabs"] as List).length,
                        (index) {
                          dynamic tab = data["tabs"][index];
                          return TabElement(
                            text: tab["text"],
                            index: index,
                            isSelected: index == _currentIndex,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // TabBarView
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    children: List.generate(
                      (data["tabs"] as List).length,
                      (index) {
                        dynamic tab = data["tabs"][index];
                        return PartnerTrainingListDetailsWidget(
                          args: {
                            "academyId": "${data["academyId"]}",
                            "id": tab["id"],
                          },
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
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "${data["academyName"]}",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      // Change the back button color here
    );
  }
}

dynamic sampleData = {
  "isSuccess": true,
  "data": {
    "response": {
      "academyId": 1,
      "academyName": "Paras Defence",
      "academyType": "Defence",
      "image": "https://i.ytimg.com/vi/TLacepiMuqk/maxresdefault.jpg",
      "tabs": [
        {
          "id": "training",
          "text": "Training",
        },
        {
          "id": "archive",
          "text": "Archive",
        }
      ]
    }
  }
};

dynamic day = {
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
