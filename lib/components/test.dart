import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final titletxt;
  final subtitletxt;
  final lefticon;
  final size;
  final type;
  final bg;
  final transparent;
  final color;
  const MyAppBar(
      {Key? key,
      this.titletxt,
      this.subtitletxt,
      this.lefticon,
      this.size,
      this.type,
      this.bg,
      this.color = Colors.black,
      this.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: (transparent == true) ? true : false,
      appBar: (size == 'small')
          ? AppBar(
              elevation: (transparent == true) ? 0 : null,
              backgroundColor: (transparent == true)
                  ? Colors.white.withOpacity(0)
                  : Colors.white,
              // backgroundColor: bg,
              leading: IconButton(onPressed: () {}, icon: Icon(lefticon)),
              actions: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (type == 'icon') ...[
                        Container(
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_outline)),
                        )
                      ] else if (type == 'button') ...[
                        Container(
                            color: Color(0xffFEE440),
                            margin: EdgeInsets.fromLTRB(0, 10, 16, 10),
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Button',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  textAlign: TextAlign.center,
                                )))
                      ] else if (type == 'action') ...[
                        Container(
                            width: 52,
                            height: 24,
                            child: const Text(
                              'Action',
                              style: TextStyle(fontSize: 16),
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
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ] else ...[
                    Text(
                      titletxt!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      subtitletxt!,
                      style: const TextStyle(
                          fontSize: 14.0, color: Color(0xff9E9E9E)),
                    )
                  ]
                ],
              ),

              // backgroundColor: bgcolor,
            )
          : PreferredSize(
              preferredSize: (subtitletxt != null)
                  ? Size.fromHeight(142.0)
                  : Size.fromHeight(114.0),
              child: AppBar(
                // (subtitletxt==null)? (): (),
                // elevation: (transparent == true) ? 0 : null,
                // backgroundColor: (transparent == true)
                //     ? Colors.white.withOpacity(0)
                //     : Colors.white,
                toolbarHeight: 114,
                leadingWidth: 343,
                leading: Container(
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
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (titletxt == null && subtitletxt == null) ...[
                              Container()
                            ] else if (subtitletxt == null) ...[
                              Container(
                                // color: Colors.red,
                                child: Text(
                                  titletxt!,
                                  style: const TextStyle(fontSize: 32.0),
                                ),
                              ),
                            ] else ...[
                              Container(
                                child: Text(
                                  titletxt!,
                                  style: const TextStyle(fontSize: 32.0),
                                ),
                              ),
                              Container(
                                child: Text(
                                  subtitletxt!,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Color(0xff9E9E9E)),
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
                              margin: EdgeInsets.fromLTRB(0, 10, 16, 68),
                              width: 79,
                              height: 36,

                              // padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Button',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff212121),
                                    ),
                                    textAlign: TextAlign.center,
                                  )))
                        ] else if (type == 'action') ...[
                          Container(
                              width: 52,
                              height: 24,
                              // color: Colors.black,
                              margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                              child: const Text('Action'))
                        ]
                      ],
                    ),
                  )
                ],
              ),
            ));
}
