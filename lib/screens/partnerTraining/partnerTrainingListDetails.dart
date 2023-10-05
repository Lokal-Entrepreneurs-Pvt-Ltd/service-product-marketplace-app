import 'package:flutter/material.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../Widgets/UikMaterialListTile/UikMaterialListTile.dart';
import '../../utils/network/ApiRepository.dart';
import 'package:google_fonts/google_fonts.dart';


class PartnerTrainingListDetailsWidget extends StatefulWidget {
  final dynamic args;
  const PartnerTrainingListDetailsWidget({super.key, this.args, Key? key});

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
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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


