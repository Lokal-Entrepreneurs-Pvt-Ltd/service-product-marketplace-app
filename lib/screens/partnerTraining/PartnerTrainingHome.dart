import 'package:flutter/material.dart';
import 'package:lokal/screens/partnerTraining/partnerTrainingListDetails.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../utils/network/ApiRepository.dart';
import '../../Widgets/UikCustomTabBar/customTabBar.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerTrainingHomeScreen extends StatefulWidget {
  const PartnerTrainingHomeScreen({Key? key});

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
    args = ModalRoute.of(context)?.settings.arguments;
    _partnerTrainingApiData = ApiRepository.getAcademyTabsScreen(args);
    super.didChangeDependencies();
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
      future: _partnerTrainingApiData, // Use the actual future
      builder: (context, AsyncSnapshot<ApiResponse> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snap.hasError) {
          return Center(
            child: Text("Something went wrong\t ${snap.error}"),
          );
        }

        dynamic data = snap.data?.data; // Use the actual data

        _tabController ??=
            TabController(length: (data["tabs"] as List).length, vsync: this);

        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.90),
          appBar: _buildAppBar(data),
          body: Column(
            children: [
              Image.network(
                data["image"],
                fit: BoxFit.cover,
                height: 153,
                width: double.infinity,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    TabBar(
                      onTap: (ind) {
                        setState(() {
                          _currentIndex = ind;
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
                            "academyId": "${args["academyId"]}",
                            "materialType": tab["id"],
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
        "${data["heading"]}",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}
