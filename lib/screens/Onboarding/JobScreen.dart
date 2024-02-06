import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikFilter.dart';

class JobsScreen extends StatefulWidget {
  JobsScreen({Key? key}) : super(key: key);

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  Map<String, List<String>> selectedTags = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildAppBar(),
          buildFilterOptions(),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.yellow.shade300, Colors.yellow.shade100],
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("Welcome Mamte"),
              Text("Welcome Mamte"),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 30,
          ),
        ],
      ),
    );
  }

  Widget buildFilterOptions() {
    return Row(
      children: [
        FilterContainer(
          onTap: () => showFilterScreen("Job Type"),
          isSelected: selectedTags.containsKey("Job Type"),
          text: 'Job Type',
        ),
        FilterContainer(
          onTap: () => showFilterScreen('Salary Range'),
          isSelected: selectedTags.containsKey('Salary Range'),
          text: 'Salary Range',
        ),
      ],
    );
  }

  void showFilterScreen(String filterType) async {
    const jsonData =
        '{"filter":{"Education":["10th","12th","graduation"],"Job Type":["full time","part time"]}}';
    final Map<String, dynamic> jsonMap = json.decode(jsonData);
    final Map<String, dynamic> filterMap =
        jsonMap['filter'] as Map<String, dynamic>;
    final Map<String, List<String>> jsonss = filterMap.map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UikFilter(
          selectedTags: selectedTags,
          data: jsonss,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedTags = result;
      });
    }
  }
}

class FilterContainer extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String text;

  FilterContainer({
    required this.onTap,
    required this.isSelected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? Colors.white : Colors.yellow,
        ),
        child: Text(text),
      ),
    );
  }
}
