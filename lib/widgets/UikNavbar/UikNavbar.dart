import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UikNavbar extends StatelessWidget implements PreferredSizeWidget {
  // final String id;
  final String size;
  final Color? backgroundColor;
  final bool? transparency;
  final String? titleText;
  final String? subtitleText;
  final Widget leftIcon;
  final String? triggerElementType;
  final Widget? triggerIcon;
  final Widget? triggerButton;
  final Widget? triggerAction;

  UikNavbar({
    required this.size,
    this.transparency,
    this.triggerIcon,
    this.triggerButton,
    this.triggerAction,
    this.backgroundColor = const Color(0xfffefefe),
    this.titleText = null,
    this.subtitleText = null,
    this.leftIcon = const Icon(null),
    this.triggerElementType = null,
  });

  @override
  Widget build(BuildContext context) => (size == 'small')
      ? Container(
          // color: (transparent==true)?,
          height: 56,
          child: AppBar(
            leadingWidth: 30,
            elevation: 0,
            // elevation: (transparency == true) ? 0 : null,
            backgroundColor:
                (transparency == true) ? Colors.transparent : backgroundColor,
            // foregroundColor: Colors.black,
            // backgroundColor: bg,
            leading: Container(
              margin: EdgeInsets.only(left: 16, top: 16),
              // color: Colors.amber,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  print("Pop");
                  Navigator.pop(context);
                },
                icon: leftIcon!,
                // iconSize: 60,
                color: Colors.black,
              ),
            ),
            actions: [
              Container(
                // color: Colors.amber,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.only(right: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (triggerElementType == 'icon') ...[
                      triggerIcon!
                    ] else if (triggerElementType == 'button') ...[
                      Container(height: 36, child: triggerButton!),
                    ] else if (triggerElementType == 'action') ...[
                      Container(
                        child: triggerAction!,
                        // color: Colors.black,
                      ),
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
                if (titleText == null) ...[
                  Container()
                ] else if (subtitleText == null) ...[
                  Text(
                    titleText!,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ] else ...[
                  Text(
                    titleText!,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subtitleText!,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3e3e3e),
                    ),
                  )
                ]
              ],
            ),

            // backgroundColor: bgcolor,
          ),
        )
      : Container(
          height: (subtitleText != null) ? (200) : (160),
          // margin: EdgeInsets.only(top: 100),
          color: (transparency == true) ? Colors.transparent : backgroundColor,
          child: Column(
            children: [
              AppBar(
                // toolbarOpacity: 0,
                elevation: 0,
                backgroundColor: (transparency == true)
                    ? Colors.transparent
                    : backgroundColor,

                foregroundColor: Colors.black,
                // (subtitletxt==null)? (): (),
                toolbarHeight: 56,
                leadingWidth: 40,
                automaticallyImplyLeading: false,

                leading: (leftIcon == null)
                    ? (Container(
                        height: 56,
                      ))
                    : Container(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        // color: Colors.amber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: leftIcon,
                            ),
                          ],
                        ),
                      ),

                //second element
                actions: [
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 7),
                    // color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (triggerElementType == 'icon') ...[
                          triggerIcon!
                        ] else if (triggerElementType == 'button') ...[
                          triggerButton!,
                        ] else if (triggerElementType == 'action') ...[
                          triggerAction!,
                        ]
                        // else if (rightElementType == 'button') ...[
                        //   Container(
                        //     margin: EdgeInsets.fromLTRB(0, 10, 10, 68),
                        //     // padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        //     width: btnwidth,
                        //     height: btnheight,
                        //     // padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                        //     child: UikButton(
                        //       backgroundColor: btncolor,
                        //       text: btntext,
                        //       textColor: btntextColor,
                        //       textSize: btntextSize,
                        //     ),
                        //   )
                        // ] else if (rightElementType == 'action') ...[
                        //   Container(
                        //       width: actionWidth,
                        //       height: actionHeight,
                        //       // color: Colors.black,
                        //       margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                        //       child: Center(
                        //           child: Text(
                        //         actionText,
                        //         style: GoogleFonts.poppins(
                        //           textStyle:
                        //               Theme.of(context).textTheme.bodyText1,
                        //           fontSize: actiontextSize,
                        //           fontWeight: FontWeight.w500,
                        //           color: actionTextColor,
                        //         ),
                        //       )))
                        // ]
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
                          if (subtitleText == null) ...[
                            Container(
                              // color: Colors.red,
                              child: Text(
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 1,
                                titleText!,
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ] else ...[
                            Container(
                              child: Text(
                                titleText!,
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                subtitleText!,
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff3e3e3e),
                                ),
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
  Size get preferredSize => (subtitleText != null)
      ? const Size.fromHeight(142.0)
      : const Size.fromHeight(114.0);
}
