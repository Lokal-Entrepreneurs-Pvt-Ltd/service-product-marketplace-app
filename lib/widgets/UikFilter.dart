import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UikFilter extends StatefulWidget {
  // final Map<String, List<String>> selectedTags;
  // final String selectedCategory;
  Map<String, dynamic>? args;
  UikFilter({this.args});

  @override
  _UikFilterState createState() => _UikFilterState();
}

class _UikFilterState extends State<UikFilter> {
  String selectedCategory = '';
  Map<String, dynamic> selectedTags = {};
  Map<String, List<String>> data = {};

  @override
  void initState() {
    super.initState();
//logic for loading data of filters
    const jsonData =
        '{"filter":{ "Education": ["10th","12th", "graduation"],"Job Type": [ "full time",  "part time"  ] , "Work Experience":[    "Fresher",    "1st year"  ],   "Salary Range":  [ "<5000",  ">5000" ] }}';
    final Map<String, dynamic> jsonMap = json.decode(jsonData);
    final Map<String, dynamic> filterMap =
        jsonMap['filter'] as Map<String, dynamic>;
    data = filterMap.map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );
    selectedTags = widget.args ?? {};
    selectedCategory = selectedTags["selectedCategory"] ?? "";
    if (selectedCategory.isEmpty) {
      selectedCategory = data.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context, getSelectedOptions());
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                        Text(
                          "Filter",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            clearAllFilters();
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              color: UikColor.charizard_400.toColor(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 22),
                            child: Text(
                              "Clear",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: "#F5F7FA".toColor(),
                            child: buildlistCategory(),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: buildFilterOptions(selectedCategory),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 14,
              right: 14,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, getSelectedOptions());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: UikColor.charizard_400.toColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 21),
                  child: Text(
                    "Apply",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        color: (selectedCategory == category)
            ? Color.fromARGB(255, 255, 252, 252)
            : null,
        child: Text(
          category,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: (selectedCategory == category)
                  ? FontWeight.w600
                  : FontWeight.w400),
        ),
      ),
    );
  }

  Widget buildlistCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: data.keys.map((key) => buildCategoryButton(key)).toList(),
    );
  }

  Widget buildFilterOptions(String title) {
    List<String> options = data[title] ?? [];

    return ListView(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options.map((option) {
          return GestureDetector(
            onTap: () {
              updateSelectedOption(title, option);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: selectedOptionColor(title, option),
                    child: selectedOptionColor(title, option) ==
                            "#FEE440".toColor()
                        ? Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 18,
                            weight: 40,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  Color selectedOptionColor(String title, String option) {
    if (selectedTags.containsKey(title) &&
        selectedTags[title]!.contains(option)) {
      return "#FEE440".toColor();
    }
    return UikColor.giratina_100.toColor();
  }

  void updateSelectedOption(String title, String option) {
    if (selectedTags.containsKey(title)) {
      if (!selectedTags[title]!.contains(option)) {
        selectedTags[title] = option;
        //   selectedTags[title]!.add(option);
      }
    } else {
      selectedTags.addAll({title: option});
    }
  }

  Map<String, dynamic> getSelectedOptions() {
    return selectedTags;
  }

  void clearAllFilters() {
    selectedTags.clear();
  }
}
