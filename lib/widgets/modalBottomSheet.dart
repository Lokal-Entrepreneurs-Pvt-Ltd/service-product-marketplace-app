import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataForFunction {
  int index;
  List<String> list;
  DataForFunction({
    required this.index,
    required this.list,
  });
}

class BottomSheetBasedOnFuture extends StatefulWidget {
  final String name;
  final Future<DataForFunction> Function() call;
  bool searchField;
  bool alternateColoring;
  BottomSheetBasedOnFuture({
    required this.name,
    required this.call,
    this.searchField = true,
    this.alternateColoring = true,
  });

  @override
  _BottomSheetBasedOnFutureState createState() =>
      _BottomSheetBasedOnFutureState();
}

class _BottomSheetBasedOnFutureState extends State<BottomSheetBasedOnFuture>
    with WidgetsBindingObserver {
  late Future<DataForFunction> _dataForFunctionFuture;
  late List<String> list;
  List<String>? filteredList;
  double bottomSheetHeight = 0;

  @override
  void initState() {
    super.initState();
    _dataForFunctionFuture = widget.call();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      bottomSheetHeight = keyboardHeight > 0 ? keyboardHeight : 0;
    });
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataForFunction>(
      future: _dataForFunctionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 100,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle errors if needed
          print("Error in async operation: ${snapshot.error}");
          return Container(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          DataForFunction dataForFunction = snapshot.data!;

          // List<String> list = dataForFunction.list;
          // List<String> filteredList = List.from(dataForFunction.list);
          list = dataForFunction.list;
          filteredList ??= list;

          double screenHeight = MediaQuery.of(context).size.height;
          double availableHeight = screenHeight -
              kToolbarHeight; // Subtracting app bar height if present
          double searchfieldheight = (widget.searchField) ? 60 : 0;
          double contentHeight =
              filteredList!.length * 40.0 + 100 + searchfieldheight;
          // Assuming each item has a height of 56.0 (adjust as needed)
          double calculatedHeight = (contentHeight > availableHeight
                  ? availableHeight
                  : contentHeight) +
              bottomSheetHeight;

          return Container(
            height: calculatedHeight,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.name}",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.dangerous_outlined),
                        onTap: () {
                          Navigator.of(context).pop(-1);
                        },
                      )
                    ],
                  ),
                ),
                (widget.searchField)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: TextFormField(
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "Search ${widget.name}",
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
                      )
                    : Container(),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected = (index == dataForFunction.index);
                      return _buildLocationItem(
                        context,
                        list,
                        filteredList![index],
                        index,
                        isSelected,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildLocationItem(
    BuildContext context,
    List<String> originalList,
    String state,
    int index,
    bool isSelected,
  ) {
    return Container(
      color: (widget.alternateColoring)
          ? isSelected
              ? Colors.yellow // Change this to your desired color
              : (index % 2 == 0 ? Colors.grey[200] : Colors.white)
          : Colors.grey[200],
      child: ListTile(
        title: Text(
          state,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        onTap: () {
          // Find the index in the original list
          int originalIndex = originalList.indexOf(state);
          Navigator.of(context).pop(originalIndex);
        },
      ),
    );
  }
}

class Bottomsheets {
  static Future<int?> showBottomListDialog({
    required BuildContext context,
    required String name,
    required Future<DataForFunction> Function() call,
    bool searchField = true,
    bool alternateColoring = true,
  }) async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return BottomSheetBasedOnFuture(
          name: name,
          call: call,
          searchField: searchField,
          alternateColoring: alternateColoring,
        );
      },
    );
  }
}
