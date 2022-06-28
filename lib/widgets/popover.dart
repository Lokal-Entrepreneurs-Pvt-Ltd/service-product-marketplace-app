import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItems extends StatelessWidget {
  final desc;
  final buttons;
  final textField;
  final image;

  const ListItems({
    Key? key,
    this.desc,
    this.buttons,
    this.textField,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: [
        //FOR IMAGE
        if (image == true) ...[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 279,
            height: 160,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image.jpg'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          )
        ],

        //FOR HEADLINE AND DESC
        Container(
          width: 310,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Column(children: [
              if (desc == true) ...[
                Container(
                    width: 279,
                    height: 70,
                    child: Column(
                      children: [
                        Container(
                            child: Text(
                          'Headline',
                          style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                        Container(
                            child: Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                      ],
                    ))
              ] else ...[
                Container(
                  width: 279,
                  height: 55,
                  child: Center(
                    child: Text(
                      'Headline',
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                )
              ]
            ]),
          ),
        ),

        // FOR TEXTFIELD
        if (textField == true) ...[
          Container(
            width: 279,
            height: 64,
            // color: const Color(0xfff5f5f5),
            decoration: const BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextField(
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Empty',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          )
        ],

        //NUMBER OF BUTTONS
        for (var i = 0; i < buttons; i++)
          Container(
            width: 279,
            height: 64,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color:
                  (i == 0) ? const Color(0xffFEE440) : const Color(0xffF5F5F5),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                'Active',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          )
      ],
    );
  }
}
