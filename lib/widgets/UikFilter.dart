import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UikFilter extends StatefulWidget {
  final Map<String, List<String>> selectedTags;
  final Map<String, List<String>> data;
  final String selectedCategory;
  UikFilter(
      {required this.selectedTags,
      required this.data,
      this.selectedCategory = ''});

  @override
  _UikFilterState createState() => _UikFilterState();
}

class _UikFilterState extends State<UikFilter> {
  String selectedCategory = '';

  Map<String, List<String>> filterOptions = {};

  @override
  void initState() {
    super.initState();

    if (widget.selectedCategory.isEmpty) {
      selectedCategory = widget.data.keys.first;
    } else {
      selectedCategory = widget.selectedCategory;
    }
    filterOptions = widget.data;
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
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            clearAllFilters();
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Text(
                              "Clear",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
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
                            color: Colors.black12,
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
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text(
                    "Apply",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
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
        color: (selectedCategory == category) ? Colors.white : null,
        child: Text(
          category,
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ),
    );
  }

  Widget buildlistCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          filterOptions.keys.map((key) => buildCategoryButton(key)).toList(),
    );
  }

  Widget buildFilterOptions(String title) {
    List<String> options = filterOptions[title] ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options.map((option) {
          return GestureDetector(
            onTap: () {
              updateSelectedOption(title, option);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: selectedOptionColor(title, option),
                    child: selectedOptionColor(title, option) == Colors.yellow
                        ? Icon(Icons.check, color: Colors.black, size: 20)
                        : null,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color selectedOptionColor(String title, String option) {
    if (widget.selectedTags.containsKey(title) &&
        widget.selectedTags[title]!.contains(option)) {
      return Colors.yellow;
    }
    return Colors.black12;
  }

  void updateSelectedOption(String title, String option) {
    if (widget.selectedTags.containsKey(title)) {
      if (!widget.selectedTags[title]!.contains(option)) {
        widget.selectedTags[title]!.clear();
        widget.selectedTags[title]!.add(option);
      }
    } else {
      widget.selectedTags.addAll({
        title: [option]
      });
    }
  }

  Map<String, List<String>> getSelectedOptions() {
    return widget.selectedTags;
  }

  void clearAllFilters() {
    widget.selectedTags.clear();
  }
}
