import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UikIcon/uikIcon.dart';

class UikNavbar extends StatelessWidget implements PreferredSizeWidget {
  final titletxt, titletxtColor, titletxtSize;
  final subtitletxt, subtitletxtColor, subtitletxtSize;
  final lefticonVal, lefticonColor, leftIconSize;
  final size;
  final type;
  final bgcolor;
  final transparent;
  final foregroundcolor;
  final btncolor,
      btnheight,
      btnwidth,
      btntext,
      btntextColor,
      btntextSize,
      lWidth;
  final actionWidth, actionHeight, actionText, actionTextColor, actiontextSize;
  final iconVal, iconColor, iconsize, iconBgcolor;
  // final height;

  const UikNavbar({
    Key? key,
    this.titletxt,
    this.subtitletxt,
    this.lefticonVal,
    this.lefticonColor,
    this.leftIconSize,
    this.size,
    this.type,
    this.bgcolor,
    this.transparent,
    this.foregroundcolor = Colors.black,
    this.btncolor,
    this.btnheight,
    this.btnwidth,
    this.btntext,
    this.lWidth,
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
    this.iconVal,
    this.iconColor,
    this.iconsize,
    this.iconBgcolor,
    // this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => (size == 'small')
      ? Container(
          // color: (transparent==true)?,
          height: 56,
          child: AppBar(
            elevation: (transparent == true) ? 0 : null,
            backgroundColor:
                (transparent == true) ? Colors.transparent : bgcolor,
            // foregroundColor: Colors.black,
            // backgroundColor: bg,
            leading: IconButton(
              onPressed: () {},
              icon: UikIcon(
                valIcon: lefticonVal,
                iconColor: lefticonColor,
                iconSize: leftIconSize,
                backgroundColor: iconBgcolor,
              ),
            ),
            actions: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (type == 'icon') ...[
                      Container(
                        child: IconButton(
                          onPressed: () {},
                          icon: UikIcon(
                            valIcon: iconVal,
                            iconColor: iconColor,
                            iconSize: iconsize,
                            backgroundColor: iconBgcolor,
                          ),
                          color: foregroundcolor,
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
                              textStyle: Theme.of(context).textTheme.bodyMedium,
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
          ),
        )
      : Container(
          height: (subtitletxt != null) ? (142) : (114),
          // margin: EdgeInsets.only(top: 100),
          color: (transparent == true) ? Colors.transparent : bgcolor,
          child: Column(
            children: [
              AppBar(
                // toolbarOpacity: 0,
                elevation: 0,
                backgroundColor:
                    (transparent == true) ? Colors.transparent : bgcolor,

                foregroundColor: foregroundcolor,
                // (subtitletxt==null)? (): (),
                toolbarHeight: 56,
                // leadingWidth: 500,
                leading: Container(
                    child: IconButton(
                  onPressed: () {},
                  icon: UikIcon(
                    valIcon: lefticonVal,
                    iconColor: lefticonColor,
                    iconSize: leftIconSize,
                    backgroundColor: iconBgcolor,
                  ),
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
                            icon: UikIcon(
                              valIcon: iconVal,
                              iconColor: iconColor,
                              iconSize: iconsize,
                              backgroundColor: iconBgcolor,
                            ),
                          )
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
              Row(
                children: [
                  Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (subtitletxt == null) ...[
                            Container(
                              // color: Colors.red,
                              child: Text(
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 1,
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
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    fontSize: subtitletxtSize,
                                    fontWeight: FontWeight.w400,
                                    color: subtitletxtColor),
                              ),
                            )
                          ]
                        ],
                      )),
                ],
              )
            ],
          ),
        );

  @override
  Size get preferredSize => (subtitletxt != null)
      ? const Size.fromHeight(142.0)
      : const Size.fromHeight(114.0);
}
