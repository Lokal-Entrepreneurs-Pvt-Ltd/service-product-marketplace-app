import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

class OtherJobDetails extends StatefulWidget {
  const OtherJobDetails({Key? key}) : super(key: key);

  @override
  State<OtherJobDetails> createState() => _OtherJobDetailsState();
}

class _OtherJobDetailsState extends State<OtherJobDetails> {
  List<int?> selectedOptions = List.filled(6, null);
  List<Map<int, int>?> answermap = [];
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final response = await ApiRepository.getQuestionsByServiceId(
          ApiRequestBody.serviceId("107"));

      if (response.isSuccess!) {
        questions = List<Map<String, dynamic>>.from(
          response.data!.map((item) => Map<String, dynamic>.from(item)),
        );
        setState(() {
          selectedOptions = List.filled(questions.length, null);
        });
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error updating data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
      persistentFooterButtons: [
        buildContinueButton(),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      title: Text(
        "Apply For Job",
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Other Details",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return buildQuestionAndAnswer(index, questions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionAndAnswer(int index, Map<String, dynamic> questionData) {
    String questionText = questionData['question']['questionText'] ?? '';
    List<Map<String, dynamic>> answers = List<Map<String, dynamic>>.from(
      questionData['answers'] ??
          [].map((item) => Map<String, dynamic>.from(item)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            answers.length,
            (answerIndex) {
              Map<String, dynamic> answer = answers[answerIndex];
              int answerId = answer['answerId'] ?? -1;
              String answerText = answer['answerText'] ?? '';

              return SelectableTextWidget(
                text: answerText,
                border: 0,
                isSelected: selectedOptions[index] == answerId,
                onTap: () => updateSelectedIndex(answerId, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Continue",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        onClick: updatedata,
      ),
    );
  }

  void updatedata() async {
    try {
      Map<String, String> userAnswers = {};
      for (int i = 0; i < questions.length; i++) {
        int? answerId = selectedOptions[i];
        if (answerId != null) {
          final maps = {
            questions[i]["questionId"].toString(): answerId.toString()
          };
          userAnswers.addEntries(maps.entries);
          //      {"questionId": questions[i]["questionId"], "answerId": answerId}
        }
      }

      final response = await ApiRepository.updateAnswersInService(
        ApiRequestBody.sendQusetionAnswers(0, 107, userAnswers),
      );

      if (response.isSuccess!) {
        UiUtils.showToast("Job Applied Successfully");
        NavigationUtils.openScreen(ScreenRoutes.onboardingScreen);
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print(e);
    }
  }

  void updateSelectedIndex(int answerId, int questionIndex) {
    setState(() {
      selectedOptions[questionIndex] = answerId;
    });
  }
}

