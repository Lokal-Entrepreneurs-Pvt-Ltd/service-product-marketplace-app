import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  final titletxt;
  final subtitletxt;
  final lefticon;
  final size;
  final type;
  final bg;
  final transparent;
  final color;

  const MyAppBar({
    Key? key,
    this.titletxt,
    this.subtitletxt,
    this.lefticon,
    this.size,
    this.type,
    this.bg,
    this.transparent,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: (transparent == true) ? true : false,
      appBar: (size == 'small')
          ? AppBar(
              elevation: (transparent == true) ? 0 : null,
              backgroundColor: (transparent == true)
                  ? Colors.white.withOpacity(0)
                  : Colors.white,
              // foregroundColor: Colors.black,
              // backgroundColor: bg,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    lefticon,
                    color: color,
                  )),
              actions: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (type == 'icon') ...[
                        Container(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_outline),
                            color: color,
                          ),
                        )
                      ] else if (type == 'button') ...[
                        Container(
                          color: const Color(0xffFEE440),
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          width: 79,
                          height: 36,
                          child: TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  'Button',
                                  style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                        )
                      ] else if (type == 'action') ...[
                        Container(
                            // color: Colors.red,
                            width: 52,
                            height: 24,
                            child: Text(
                              'Action',
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ))
                      ]
                    ],
                  ),
                )
              ],
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (titletxt == null) ...[
                    Container()
                  ] else if (subtitletxt == null) ...[
                    Text(
                      titletxt!,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ] else ...[
                    Text(
                      titletxt!,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      subtitletxt!,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff9e9e9e),
                        // color: Colors.black,
                      ),
                    )
                  ]
                ],
              ),

              // backgroundColor: bgcolor,
            )
          : PreferredSize(
              preferredSize: (subtitletxt != null)
                  ? const Size.fromHeight(142.0)
                  : const Size.fromHeight(114.0),
              child: Container(
                child: AppBar(
                  backgroundColor: bg,
                  foregroundColor: Colors.black,
                  // (subtitletxt==null)? (): (),
                  toolbarHeight: 122,
                  leadingWidth: 343,
                  leading: Container(
                      // color: Colors.red,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                lefticon,
                                color: Colors.black,
                              ))),
                      Container(
                          // color: Colors.red,
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (subtitletxt == null) ...[
                                Container(
                                  // color: Colors.red,
                                  child: Text(
                                    titletxt!,
                                    style: GoogleFonts.poppins(
                                      textStyle:
                                          Theme.of(context).textTheme.headline1,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                Container(
                                  child: Text(
                                    titletxt!,
                                    style: GoogleFonts.poppins(
                                      textStyle:
                                          Theme.of(context).textTheme.headline1,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  // margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    subtitletxt!,
                                    style: GoogleFonts.poppins(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]
                            ],
                          )),
                    ],
                  )),
                  //second element
                  actions: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (type == 'icon') ...[
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_outline))
                          ] else if (type == 'button') ...[
                            Container(
                                color: Colors.yellow,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 68),
                                // padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                width: 79,
                                height: 36,

                                // padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Center(
                                      child: Text(
                                        'Button',
                                        style: GoogleFonts.poppins(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )))
                          ] else if (type == 'action') ...[
                            Container(
                                width: 52,
                                height: 24,
                                // color: Colors.black,
                                margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                                child: Center(
                                    child: Text(
                                  'Action',
                                  style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )))
                          ]
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
}
