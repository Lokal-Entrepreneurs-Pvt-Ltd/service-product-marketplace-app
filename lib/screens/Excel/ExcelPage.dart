import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class ExcelPage extends StatelessWidget {
  const ExcelPage({super.key});

  Future<void> exportToExcel() async {
    ByteData data = await rootBundle
        .load('assets/files/_assets_upload_participant_upload.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(
          "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        print('$row');
      }
    }
    var fileBytes = excel.save();
    // var directory = await getApplicationDocumentsDirectory();

    File('assets/files/_assets_upload_participant_upload.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!, flush: true);
    // final stopWatch = Stopwatch()..start();

    // final excel = Excel.createExcel();
    // final sheet = excel[excel.getDefaultSheet()!];

    // for (var row = 0; row < columns.length; row++) {
    //   sheet
    //       .cell(CellIndex.indexByColumnRow(columnIndex: row, rowIndex: 0))
    //       .value = columns[row];
    // }

    // for (var row = 0; row < list.length; row++) {
    //   if (list[row].length == 10) {
    //     for (var col = 0; col < list[row].length; col++) {
    //       sheet
    //           .cell(CellIndex.indexByColumnRow(
    //               columnIndex: col, rowIndex: row + 1))
    //           .value = list[row][columns[col]];
    //     }
    //   } else {
    //     for (var col = 0; col < list[row].length - 1; col++) {
    //       sheet
    //           .cell(CellIndex.indexByColumnRow(
    //               columnIndex: col, rowIndex: row + 1))
    //           .value = list[row][columns[col]];
    //     }
    //   }
    // }
    // // excel.save(fileName: "MyDataOfSubscribers.xlsx");
    // if (MediaQuery.of(context).size.width > 600) {
    //   excel.save(fileName: "${title}.xlsx");
    // } else {
    //   var fileBytes = excel.save();
    //   var directory = await getApplicationDocumentsDirectory();

    //   File("$directory/VleManagement.xlsx")
    //     ..createSync(recursive: true)
    //     ..writeAsBytesSync(fileBytes!, flush: true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Excel"),
          onPressed: () {
            exportToExcel();
          },
        ),
      ),
    );
  }
}
