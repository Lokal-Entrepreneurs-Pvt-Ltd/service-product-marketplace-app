import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UikiIcon/uikIcon.dart';

class MyAppBar extends StatelessWidget {
  final titletxt, titletxtColor, titletxtSize;
  final subtitletxt, subtitletxtColor, subtitletxtSize;
  final lefticon;
  final size;
  final type;
  final bg;
  final transparent;
  final color;
  final btncolor, btnheight, btnwidth, btntext, btntextColor, btntextSize;
  final actionWidth, actionHeight, actionText, actionTextColor, actiontextSize;

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
    this.btncolor,
    this.btnheight,
    this.btnwidth,
    this.btntext,
    this.btntextColor,
    this.btntextSize,
    this.actionWidth,
    this.actionHeight,
    this.actionText,
    this.actionTextColor,
    this.actiontextSize,
    this.titletxtColor,
    this.titletxtSize,
    this.subtitletxtColor,
    this.subtitletxtSize,
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
                            icon: UikIcon(),
                            color: color,
                          ),
                        )
                      ] else if (type == 'button') ...[
                        Container(
                          color: btncolor,
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          width: btnwidth,
                          height: btnheight,
                          child: TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  btntext,
                                  style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                    fontSize: btntextSize,
                                    fontWeight: FontWeight.w500,
                                    color: btntextColor,
                                  ),
                                ),
                              )),
                        )
                      ] else if (type == 'action') ...[
                        Container(
                            // color: Colors.red,
                            width: actionWidth,
                            height: actionHeight,
                            child: Text(
                              actionText,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                fontSize: actiontextSize,
                                fontWeight: FontWeight.w500,
                                color: actionTextColor,
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
                        fontSize: titletxtSize,
                        fontWeight: FontWeight.w500,
                        color: titletxtColor,
                      ),
                    ),
                  ] else ...[
                    Text(
                      titletxt!,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: titletxtSize,
                        fontWeight: FontWeight.w500,
                        color: titletxtColor,
                      ),
                    ),
                    Text(
                      subtitletxt!,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: subtitletxtSize,
                        fontWeight: FontWeight.w500,
                        color: subtitletxtColor,
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
                  foregroundColor: color,
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
                                color: color,
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
                                      fontSize: titletxtSize,
                                      fontWeight: FontWeight.w600,
                                      color: titletxtColor,
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
                                      fontSize: titletxtSize,
                                      fontWeight: FontWeight.w600,
                                      color: titletxtColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  // margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    subtitletxt!,
                                    style: GoogleFonts.poppins(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: subtitletxtSize,
                                        fontWeight: FontWeight.w400,
                                        color: subtitletxtColor),
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
                            IconButton(onPressed: () {}, icon: UikIcon())
                          ] else if (type == 'button') ...[
                            Container(
                                color: btncolor,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 68),
                                // padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                width: btnwidth,
                                height: btnheight,

                                // padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Center(
                                      child: Text(
                                        btntext,
                                        style: GoogleFonts.poppins(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: btntextSize,
                                          fontWeight: FontWeight.w500,
                                          color: btntextColor,
                                        ),
                                      ),
                                    )))
                          ] else if (type == 'action') ...[
                            Container(
                                width: actionWidth,
                                height: actionHeight,
                                // color: Colors.black,
                                margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                                child: Center(
                                    child: Text(
                                  actionText,
                                  style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    fontSize: actiontextSize,
                                    fontWeight: FontWeight.w500,
                                    color: actionTextColor,
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
