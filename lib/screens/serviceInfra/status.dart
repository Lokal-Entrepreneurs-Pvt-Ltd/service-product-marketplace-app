import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

class StatusListScreen extends StatefulWidget {
  final dynamic args;
  const StatusListScreen({Key? key, this.args}) : super(key: key);

  @override
  State<StatusListScreen> createState() => _StatusListScreenState();
}

class _StatusListScreenState extends State<StatusListScreen> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _fetchCustomerData();
    setState(() {});
  }

  Future<void> _fetchCustomerData() async {
    try {
      List<dynamic> rawData = [
        {"title": "Applied for the job", "isComplete": false},
        {"title": "Document Submitted", "isComplete": true},
        {"title": "Verification", "isComplete": false},
        {"title": "User Onboard", "isComplete": true},
      ];
      _updateCustomerData(rawData);
    } catch (e) {
      _handleApiError();
    }
  }

  void _updateCustomerData(List<dynamic> data) {
    setState(() {
      _tasks = data.map((data) {
        return Task(
          title: data["title"] ?? "",
          isComplete: data["isComplete"] ?? false,
        );
      }).toList();
      _isLoading = false;
    });
  }

  void _handleApiError() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _buildLoadingIndicator() : _buildStatusList(),
      // persistentFooterButtons:
      //     _showAddCustomerButton ? [_buildAddCustomerButton()] : [],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }

  Widget _buildStatusList() {
    return Container(
      color: Colors.black.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            textNameContainer(),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return buildTaskItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTaskItem(int index) {
    return Container(
      height: 94.6,
      color: Colors.white,
      //   decoration: BoxDecoration(border: Border.all()),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  (index != 0)
                      ? buildUpperVerticalLine(_tasks[index - 1].isComplete
                          ? Colors.green
                          : Colors.grey.shade300)
                      : Container(
                          height: 18.6,
                          width: 0,
                        ),
                  buildCheckIcon(index, _tasks[index]),
                  (index == _tasks.length - 1)
                      ? Container(
                          height: 44.6,
                          width: 0,
                        )
                      : buildBelowVerticalLine(_tasks[index].isComplete
                          ? Colors.green
                          : Colors.grey.shade300),
                ],
              ),
              SizedBox(width: 11),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Expanded(
                  child: Text(
                    _tasks[index].title,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          (!_tasks[index].isComplete) ? _buildCallButton() : Container(),
        ],
      ),
    );
  }

  Widget buildUpperVerticalLine(Color color) {
    return Container(
      height: 18.6,
      width: 2,
      color: color,
    );
  }

  Widget buildBelowVerticalLine(Color color) {
    return Container(
      height: 46,
      width: 2,
      color: color,
    );
  }

  Widget buildCheckIcon(int index, Task task) {
    return InkWell(
      onTap: () {
        setState(() {
          task.isComplete = !task.isComplete;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: task.isComplete ? Colors.green : Colors.grey.shade300,
        ),
        child: (task.isComplete)
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  textNameContainer() {
    return Container(
      height: 80,
      // width: 109,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      // margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 4, color: Colors.black54),
        ),
      ),
      child: Row(
        children: [
          Image.network(
            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1704892981939-avatar.png",
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gaurav Singh",
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // return ListTile(
    //   leading: Image.network(
    //     "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1704891617283-Vector%20(1).png",
    //     width: 18,
    //     height: 18,
    //   ),
    //   title: Text(
    //     "Remind",
    //     style: GoogleFonts.poppins(
    //       fontSize: 12,
    //       fontWeight: FontWeight.w500,
    //       color: Colors.white,
    //     ),
    //   ),
    // );
  }

  Widget _buildCallButton() {
    return InkWell(
      onTap: () async {},
      child: Container(
        height: 45,
        // width: 109,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        // margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.green,
        ),
        child: Row(
          children: [
            Image.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1704891617283-Vector%20(1).png",
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Remind",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetryView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "No Customer Added Yet. Kindly Add a Customer! ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center, // Center-align the text
        ),
        const SizedBox(height: 20), // Add some vertical spacing
        ElevatedButton(
          onPressed: () {
            // Call the retry method here
            setState(() {
              _isLoading = true;
              _fetchCustomerData();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.yellow, // Set button background color to yellow
          ),
          child: const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
            child: Text(
              "Retry",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set text color to black
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Task {
  final String title;
  bool isComplete;

  Task({
    required this.title,
    required this.isComplete,
  });
}
