// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';

class DataForFunction {
  int index;
  List<String> list;
  DataForFunction({
    required this.index,
    required this.list,
  });
}

class Bottomsheets {
  static Future<int?> showLocationDialog(
    BuildContext context,
    List<String> list,
    String name,
    Future<DataForFunction> Function() call,
  ) async {
    TextEditingController searchController = TextEditingController();
    DataForFunction dataForFunction = DataForFunction(index: -1, list: []);
    List<String> list = [];
    List<String> filteredList = List.from(list);

    // Capture the context before entering the async operation
    final dialogContext = context;

    showModalBottomSheet(
      context: dialogContext,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
          ),
        );
      },
    );

    try {
      dataForFunction = await call();
      list = dataForFunction.list;
      filteredList = List.from(dataForFunction.list);
    } catch (error) {
      // Handle errors if needed
      print("Error in async operation: $error");
    } finally {
      // Close the loading indicator regardless of success or failure
      Navigator.of(dialogContext).pop();
    }

    return showModalBottomSheet<int>(
      backgroundColor: Colors.white,
      context: dialogContext,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double availableHeight = screenHeight -
            kToolbarHeight; // Subtracting app bar height if present

        double contentHeight = filteredList.length * 56.0 +
            180; // Assuming each item has a height of 56.0 (adjust as needed)
        double calculatedHeight =
            contentHeight > availableHeight ? availableHeight : contentHeight;

        return Container(
          height: calculatedHeight,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select $name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          child: Icon(Icons.dangerous_outlined),
                          onTap: () {
                            Navigator.of(dialogContext).pop(-1);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: TextFormField(
                      controller: searchController,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search $name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          filteredList = list
                              .where((element) => element
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected = (index == dataForFunction.index);
                        return _buildLocationItem(
                          dialogContext,
                          list,
                          filteredList[index],
                          index,
                          isSelected,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  static Widget _buildLocationItem(
    BuildContext context,
    List<String> originalList,
    String state,
    int index,
    bool isSelected,
  ) {
    return Container(
      color: isSelected
          ? UikColor.charizard_400.toColor()
          : (index % 2 == 0 ? Colors.grey[200] : Colors.white),
      child: ListTile(
        title: Text(state),
        onTap: () {
          // Find the index in the original list
          int originalIndex = originalList.indexOf(state);
          Navigator.of(context).pop(originalIndex);
        },
      ),
    );
  }
}
