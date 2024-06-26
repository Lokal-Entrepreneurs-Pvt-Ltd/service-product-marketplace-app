import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';

import '../../../constants/json_constants.dart';

class ApplyForJobServiceQuestions extends StatefulWidget {
  const ApplyForJobServiceQuestions({Key? key, this.args}) : super(key: key);
  final dynamic args;

  @override
  State<ApplyForJobServiceQuestions> createState() =>
      _ApplyForJobServiceQuestionsState();
}

class _ApplyForJobServiceQuestionsState
    extends State<ApplyForJobServiceQuestions> {
  List<int?> selectedAnswers = [];
  List<Map<int, int?>?> answermap = [];
  List<Map<String, dynamic>> questions = [];
  bool isDataLoaded = false;
  bool isError = false; // Flag to check API error

  Future<void> loadData() async {
    try {
      final response = await ApiRepository.getQuestionsByServiceId(widget.args);

      if (response.isSuccess!) {
        questions = List<Map<String, dynamic>>.from(
          response.data!.map((item) => Map<String, dynamic>.from(item)),
        );
        setState(() {
          selectedAnswers = List.generate(questions.length, (index) => null);
          isDataLoaded = true; // Set the flag to true once data is loaded
        });
      } else {
        // Set the error flag to true when API fails
        setState(() {
          isError = true;
          isDataLoaded = true; // Set the flag to true in case of error
        });
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print(e);
      // Set the error flag to true when there's an exception
      setState(() {
        isError = true;
        isDataLoaded = true; // Set the flag to true in case of exception
      });
      UiUtils.showToast("Error updating data");
    }
  }

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: isDataLoaded
          ? buildBody()
          : isError
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0), // Add padding here
                    child: Text(
                      "No Job Specific Question for the Job, Kindly Apply By Pressing the Button",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator(color: Colors.yellow)),
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
        icon: const Icon(Icons.arrow_back),
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
        const SizedBox(height: 15),
        Column(
          children: List.generate(
            answers.length,
            (answerIndex) {
              Map<String, dynamic> answer = answers[answerIndex];
              int answerId = answer['answerId'] ?? -1;
              String answerText = answer['answerText'] ?? '';

              return RadioListTile<int?>(
                title: Text(answerText),
                value: answerId,
                groupValue: selectedAnswers[index],
                onChanged: (int? value) {
                  setState(() {
                    selectedAnswers[index] = value;
                  });
                },
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
        text: "Apply for the Job",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        onClick: () {
          bool allQuestionsAnswered = selectedAnswers.every(
            (value) => value != null,
          );

          if (!allQuestionsAnswered) {
            // Show a toast message if not all questions are answered
            UiUtils.showToast(
                "Please answer all questions before applying for the job");
          } else {
            updatedata();
          }
        },
      ),
    );
  }

  void updatedata() async {
    final response = await ApiRepository.updateAnswersInService(
      ApiRequestBody.sendQusetionAnswers(widget.args["serviceId"], {}),
    );

    if (response.isSuccess!) {
      UiUtils.showToast("Job Applied Successfully");
      if (widget.args["serviceType"] == "jobs_delivery") {
        NavigationUtils.pushAndPopUntil(
          ScreenRoutes.deliveryJobsDetailsPage,
          ScreenRoutes.deliveryJobsDetailsPage,
          widget.args,
        );
      } else {
        NavigationUtils.pushAndPopUntil(
          ScreenRoutes.jobsDetailsPage,
          ScreenRoutes.jobsDetailsPage,
          widget.args,
        );
      }
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
    }
  }
}
