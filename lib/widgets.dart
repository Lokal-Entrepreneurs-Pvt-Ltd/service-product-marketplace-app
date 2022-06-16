import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:login/pages/test_screen1.dart';
import 'package:login/utils/components.dart';

final List<String> imageList = [
  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class Widgets {
  Widgets() {}
  List<Widget> widgetList1 = [
    SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Local",
            style:
                GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: ("Search"),
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 16))),
          ),
          SizedBox(
            height: 25,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Components().slideItems("best of \n 2020", imageList[0]),
                Components().slideItems("the golden hour", imageList[1]),
                Components().slideItems("lonely kitchen", imageList[2]),
                Components().slideItems("summer \n choice", imageList[3]),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("living room", "${imageList[0]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("bed room", "${imageList[1]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("living room", "${imageList[2]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("kitchen", "${imageList[3]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("living room", "${imageList[0]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("bed room", "${imageList[1]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("living room", "${imageList[2]}"),
          SizedBox(
            height: 25,
          ),
          Components().listItemScreen1("kitchen", "${imageList[3]}"),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    )
  ];
}
